const fs = require('fs');
const path = require('path');

function isExternalUrl(url) {
  return /^([a-z]+:)?\/\//i.test(url);
}

function normalizeLocalRef(url) {
  const clean = String(url || '').trim();
  if (!clean) return null;
  if (clean.startsWith('#')) return null;
  if (clean.startsWith('mailto:')) return null;
  if (clean.startsWith('tel:')) return null;
  if (clean.startsWith('data:')) return null;
  if (isExternalUrl(clean)) return null;

  const withoutHash = clean.split('#')[0];
  const withoutQuery = withoutHash.split('?')[0];
  if (!withoutQuery) return null;
  return withoutQuery.replace(/^\//, '');
}

function safeDecodePath(p) {
  try {
    return decodeURIComponent(p);
  } catch {
    return p;
  }
}

function extractRefsFromHtml(html) {
  const refs = new Set();
  const re = /(src|href|srcset|data-src|data-srcset)\s*=\s*"([^"]+)"/g;
  let m;
  while ((m = re.exec(html))) {
    const attr = m[1];
    const value = m[2];
    if (attr === 'srcset' || attr === 'data-srcset') {
      String(value || '')
        .split(',')
        .map(s => s.trim())
        .filter(Boolean)
        .forEach(item => {
          const url = item.split(/\s+/)[0];
          if (url) refs.add(url);
        });
      continue;
    }

    refs.add(value);
  }
  return [...refs];
}

function checkFileRefs(entryHtmlPath) {
  const absEntry = path.isAbsolute(entryHtmlPath)
    ? entryHtmlPath
    : path.join(process.cwd(), entryHtmlPath);

  const html = fs.readFileSync(absEntry, 'utf8');
  const raw = extractRefsFromHtml(html);
  const local = raw.map(normalizeLocalRef).filter(Boolean).map(safeDecodePath);
  const missing = [];

  for (const ref of local) {
    const abs = path.join(process.cwd(), ref);
    if (!fs.existsSync(abs)) missing.push(ref);
  }

  return {
    entry: path.relative(process.cwd(), absEntry),
    localCount: local.length,
    missingCount: missing.length,
    missing
  };
}

function main() {
  const entry = process.argv[2] || 'index.html';
  const result = checkFileRefs(entry);
  process.stdout.write(JSON.stringify(result, null, 2) + '\n');
  process.exit(result.missingCount ? 2 : 0);
}

main();
