import { cp, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { existsSync } from "node:fs";

const outDir = "dist";
const siteConfig = await loadJsonConfig("site.config.json");
const env = await loadEnv(".env");
const config = { ...siteConfig, ...env };
await rm(outDir, { recursive: true, force: true });
await mkdir(outDir, { recursive: true });

for (const file of ["index.html"]) {
  await cp(file, `${outDir}/${file}`);
}

await cp("src", `${outDir}/src`, { recursive: true });
if (existsSync("documentation")) {
  await cp("documentation", `${outDir}/documentation`, { recursive: true });
}
if (existsSync("public")) {
  await cp("public", `${outDir}/public`, { recursive: true });
}

await applyConfigToIndex(`${outDir}/index.html`, config);
console.log("Built static site to dist/");

async function loadJsonConfig(path) {
  if (!existsSync(path)) return {};
  return JSON.parse(await readFile(path, "utf8"));
}

async function loadEnv(path) {
  if (!existsSync(path)) return {};
  const source = await readFile(path, "utf8");
  const values = {};

  for (const rawLine of source.split(/\r?\n/)) {
    const line = rawLine.trim();
    if (!line || line.startsWith("#")) continue;
    const eq = line.indexOf("=");
    if (eq === -1) continue;

    const key = line.slice(0, eq).trim();
    let value = line.slice(eq + 1).trim();
    if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
      value = value.slice(1, -1);
    }
    values[key] = value;
  }

  return values;
}

async function applyConfigToIndex(path, config) {
  let html = await readFile(path, "utf8");
  const pumpfunUrl = config.PUMPFUN_URL || "#pumpfun-soon";
  const caText = config.CA_TEXT || "CA: SOON";

  html = html.replace(/href="[^"]*" data-env-href="PUMPFUN_URL"/g, `href="${escapeAttr(pumpfunUrl)}" data-env-href="PUMPFUN_URL"`);
  html = html.replace(/(<[^>]*data-env-text="CA_TEXT"[^>]*>)(.*?)(<\/[^>]+>)/g, `$1${escapeHtml(caText)}$3`);

  await writeFile(path, html);
}

function escapeAttr(value) {
  return String(value).replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;");
}

function escapeHtml(value) {
  return String(value).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
