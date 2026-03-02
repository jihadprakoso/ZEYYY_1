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

const widths = [480, 768, 960, 1600];
const quality = 72;

async function fileStatOrNull(p) {
  try {
    return await fs.stat(p);
  } catch {
    return null;
  }
}

async function ensureDir(p) {
  await fs.mkdir(p, { recursive: true });
}

function outPathFor(inputRel, width) {
  const dir = path.dirname(inputRel);
  const base = path.basename(inputRel, path.extname(inputRel));
  return path.join(dir, `${base}-${width}w.webp`);
}

async function buildOne(inputRel) {
  const inputAbs = path.join(root, inputRel);
  const inStat = await fileStatOrNull(inputAbs);
  if (!inStat) throw new Error(`File tidak ditemukan: ${inputRel}`);

  await ensureDir(path.dirname(inputAbs));

  const img = sharp(inputAbs, { failOn: 'none' });
  const meta = await img.metadata();
  const sourceWidth = meta && meta.width ? meta.width : null;

  for (const w of widths) {
    if (sourceWidth && w > sourceWidth) continue;
    const outRel = outPathFor(inputRel, w);
    const outAbs = path.join(root, outRel);
    await ensureDir(path.dirname(outAbs));

    await sharp(inputAbs, { failOn: 'none' })
      .resize({ width: w, withoutEnlargement: true })
      .webp({ quality, effort: 6 })
      .toFile(outAbs);
  }
}

async function main() {
  for (const t of targets) {
    await buildOne(t);
  }
  process.stdout.write('OK\n');
}

main().catch((err) => {
  process.stderr.write(String(err && err.stack ? err.stack : err) + '\n');
  process.exitCode = 1;
});
