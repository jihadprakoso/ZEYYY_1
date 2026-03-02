import fs from 'node:fs/promises';
import path from 'node:path';

function toPosix(p) {
  return p.split(path.sep).join('/');
}

function safeDecode(uri) {
  try {
    return decodeURIComponent(uri);
  } catch {
    return uri;
  }
}

function normalizeAssetRef(ref) {
  if (!ref) return null;
  let v = String(ref).trim();
  v = v.replace(/^[('"`]+/, '').replace(/[)"'`]+$/, '');
  v = v.replace(/[#?].*$/, '');

  const idx = v.indexOf('/assets/');
  if (idx !== -1) v = v.slice(idx + 1);

  if (!v.startsWith('assets/')) return null;
  v = safeDecode(v);
  v = v.replace(/^assets\/+/, 'assets/');
  return v;
}

async function fileExists(filePath) {
  try {
    await fs.access(filePath);
    return true;
  } catch {
    return false;
  }
}

async function walkFiles(dirAbs) {
  const out = [];
  const stack = [dirAbs];

  while (stack.length) {
    const cur = stack.pop();
    const entries = await fs.readdir(cur, { withFileTypes: true });
    for (const e of entries) {
      const abs = path.join(cur, e.name);
      if (e.isDirectory()) {
        stack.push(abs);
      } else if (e.isFile()) {
        out.push(abs);
      }
    }
  }

  return out;
}

async function readTextIfExists(p) {
  if (!(await fileExists(p))) return null;
  return fs.readFile(p, 'utf8');
}

function extractAssetRefsFromText(text) {
  const refs = new Set();

  const relRe = /assets\/[A-Za-z0-9._%\-\/\s]+?\.[A-Za-z0-9]{2,8}/g;
  const absRe = /https?:\/\/[^\s"'()]+?\/assets\/[A-Za-z0-9._%\-\/\s]+?\.[A-Za-z0-9]{2,8}/g;

  for (const m of text.matchAll(relRe)) refs.add(m[0]);
  for (const m of text.matchAll(absRe)) refs.add(m[0]);

  return refs;
}

async function main() {
  const root = process.cwd();
  const sourceCandidates = [
    'index.html',
    'privacy-policy.html',
    'terms-of-service.html',
    '404.html',
    'optimized_styles.css',
    'optimized_script.js',
    'dist/index.html',
    'dist/privacy-policy.html',
    'dist/terms-of-service.html',
    'dist/404.html',
    'dist/optimized_styles.css',
    'dist/optimized_script.js',
  ].map(p => path.join(root, p));

  const used = new Set();
  const usedRaw = new Set();

  for (const filePath of sourceCandidates) {
    const text = await readTextIfExists(filePath);
    if (!text) continue;
    for (const raw of extractAssetRefsFromText(text)) {
      usedRaw.add(raw);
      const n = normalizeAssetRef(raw);
      if (n) used.add(n);
    }
  }

  const assetsDir = path.join(root, 'assets');
  if (!(await fileExists(assetsDir))) {
    throw new Error('Folder assets/ tidak ditemukan di project root.');
  }

  const assetFilesAbs = await walkFiles(assetsDir);
  const assetFilesRel = assetFilesAbs.map(abs => {
    const rel = path.relative(root, abs);
    return toPosix(rel);
  });

  const assetsRelSet = new Set(assetFilesRel);

  const missing = [];
  for (const ref of used) {
    if (!assetsRelSet.has(ref)) missing.push(ref);
  }

  const unused = [];
  for (const rel of assetFilesRel) {
    if (!used.has(rel)) unused.push(rel);
  }

  const sizeByRel = new Map();
  let totalBytes = 0;
  let unusedBytes = 0;
  for (const abs of assetFilesAbs) {
    const st = await fs.stat(abs);
    const rel = toPosix(path.relative(root, abs));
    sizeByRel.set(rel, st.size);
    totalBytes += st.size;
    if (!used.has(rel)) unusedBytes += st.size;
  }

  unused.sort((a, b) => a.localeCompare(b));
  missing.sort((a, b) => a.localeCompare(b));

  const reportLines = [];
  reportLines.push('# Asset Audit Report');
  reportLines.push('');
  reportLines.push(`- Total file di assets/: ${assetFilesRel.length}`);
  reportLines.push(`- Direferensikan (used): ${used.size}`);
  reportLines.push(`- Tidak direferensikan (unused): ${unused.length}`);
  reportLines.push(`- Total ukuran assets/: ${totalBytes} bytes`);
  reportLines.push(`- Estimasi bisa dihapus: ${unusedBytes} bytes`);
  reportLines.push('');
  reportLines.push('## Missing (Direferensikan tapi file tidak ada)');
  if (missing.length === 0) {
    reportLines.push('- (Tidak ada)');
  } else {
    for (const m of missing) reportLines.push(`- ${m}`);
  }
  reportLines.push('');
  reportLines.push('## Unused (Aman untuk dihapus berdasarkan scan)');
  if (unused.length === 0) {
    reportLines.push('- (Tidak ada)');
  } else {
    for (const u of unused) {
      const sz = sizeByRel.get(u) ?? 0;
      reportLines.push(`- ${u} (${sz} bytes)`);
    }
  }
  reportLines.push('');

  await fs.writeFile(path.join(root, 'ASSET_AUDIT_REPORT.md'), reportLines.join('\n'), 'utf8');
  await fs.writeFile(path.join(root, 'unused-assets.txt'), unused.join('\n') + (unused.length ? '\n' : ''), 'utf8');
  await fs.writeFile(path.join(root, 'missing-assets.txt'), missing.join('\n') + (missing.length ? '\n' : ''), 'utf8');

  const summary = {
    total: assetFilesRel.length,
    used: used.size,
    unused: unused.length,
    totalBytes,
    unusedBytes,
    missing: missing.length,
    report: 'ASSET_AUDIT_REPORT.md',
    unusedList: 'unused-assets.txt',
    missingList: 'missing-assets.txt',
  };
  process.stdout.write(JSON.stringify(summary, null, 2) + '\n');
}

main().catch(err => {
  process.stderr.write(String(err && err.stack ? err.stack : err) + '\n');
  process.exitCode = 1;
});

