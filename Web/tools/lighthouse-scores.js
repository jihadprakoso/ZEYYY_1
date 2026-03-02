const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

function run(cmd, args) {
  return new Promise((resolve, reject) => {
    const child = spawn(cmd, args, { shell: true, windowsHide: true });
    let stdout = '';
    let stderr = '';

    child.stdout.setEncoding('utf8');
    child.stderr.setEncoding('utf8');
    child.stdout.on('data', (d) => (stdout += d));
    child.stderr.on('data', (d) => (stderr += d));

    child.on('error', reject);
    child.on('close', (code) => {
      if (code !== 0) {
        const err = new Error(`Command failed (${code})`);
        err.stdout = stdout;
        err.stderr = stderr;
        reject(err);
        return;
      }
      resolve({ stdout, stderr });
    });
  });
}

function extractScores(lhrJson) {
  const categories = (lhrJson && lhrJson.categories) || {};
  return {
    performance: categories.performance && categories.performance.score,
    accessibility: categories.accessibility && categories.accessibility.score,
    bestPractices: categories['best-practices'] && categories['best-practices'].score,
    seo: categories.seo && categories.seo.score
  };
}

async function main() {
  const url = process.argv[2] || 'http://localhost:8001/';
  const preset = process.argv[3] || 'desktop';
  const outputFile = process.argv[4];

  const args = ['lighthouse', url];
  if (preset === 'desktop') {
    args.push('--preset=desktop');
  } else if (preset === 'mobile') {
    args.push('--form-factor=mobile');
  }
  args.push(
    '--only-categories=performance,accessibility,best-practices,seo',
    '--output=json',
    '--output-path=stdout',
    '--quiet',
    '--no-enable-error-reporting'
  );

  const { stdout } = await run('npx.cmd', ['--yes', ...args]);
  if (outputFile) {
    const abs = path.isAbsolute(outputFile) ? outputFile : path.join(process.cwd(), outputFile);
    fs.writeFileSync(abs, stdout, 'utf8');
  }
  const parsed = JSON.parse(stdout);
  const scores = extractScores(parsed);
  process.stdout.write(JSON.stringify({ url, preset, scores }) + '\n');
}

main().catch((err) => {
  process.stderr.write((err && err.message ? err.message : String(err)) + '\n');
  if (err && err.stderr) process.stderr.write(err.stderr.slice(0, 2000) + '\n');
  process.exit(1);
});
