import fs from 'node:fs/promises';
import path from 'node:path';
import sharp from 'sharp';

const root = process.cwd();

const targets = [
  'assets/images/halamanutama/custom-01.webp',
  'assets/images/halamanutama/custom-02.webp',
  'assets/images/halamanutama/hardbox-hmns2.webp',
  'assets/images/halamanutama/hardbox-love-in-motion.webp',
  'assets/images/halamanutama/hardbox-custom-deartbox.webp',
  'assets/images/halamanutama/hardbox-W3B.webp'
];

const quality = 78;

async function statSize(abs) {
  const st = await fs.stat(abs);
  return st.size;
}

async function recompressOne(rel) {
  const abs = path.join(root, rel);
  const before = await statSize(abs);
  const buf = await sharp(abs, { failOn: 'none' }).webp({ quality, effort: 6 }).toBuffer();
  const after = buf.byteLength;
  if (after >= before) return { rel, before, after: before, kept: true };
  await fs.writeFile(abs, buf);
  return { rel, before, after, kept: false };
}

async function main() {
  const results = [];
  for (const t of targets) results.push(await recompressOne(t));
  process.stdout.write(JSON.stringify(results, null, 2) + '\n');
}

main().catch((err) => {
  process.stderr.write(String(err && err.stack ? err.stack : err) + '\n');
  process.exitCode = 1;
});
