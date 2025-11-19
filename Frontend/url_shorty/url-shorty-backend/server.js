import express from "express";
import cors from "cors";
import crypto from "crypto";
import path from "path";
import fs from "fs/promises";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors({ origin: true }));
app.use(express.json());

const DATA_DIR = path.join(__dirname, "data");
const DATA_FILE = path.join(DATA_DIR, "links.json");

async function ensureDataDir() { await fs.mkdir(DATA_DIR, { recursive: true }); }
async function loadLinks() {
  try { await ensureDataDir(); const raw = await fs.readFile(DATA_FILE, "utf-8"); const parsed = JSON.parse(raw); return Array.isArray(parsed)?parsed:[]; }
  catch { return []; }
}
async function saveLinks(links) {
  const tmp = DATA_FILE + ".tmp";
  await fs.writeFile(tmp, JSON.stringify(links, null, 2), "utf-8");
  await fs.rename(tmp, DATA_FILE);
}

function isValidUrl(u) { try { const url = new URL(u); return ["http:","https:"].includes(url.protocol); } catch { return false; } }
const slugRegex = /^[a-zA-Z0-9_-]{3,32}$/;
const randomSlug = () => crypto.randomBytes(4).toString("hex");
function shortUrlFromReq(req, slug) { const proto = req.get("x-forwarded-proto") || "http"; const host = req.get("host"); return `${proto}://${host}/r/${slug}`; }

let links = [];
loadLinks().then(l=>{ links=l; console.log(`Betöltve ${links.length} link a JSON-ból.`); });

app.get("/api/links", (req, res) => {
  const { q = "", sort = "createdAt", dir = "desc" } = req.query;
  const dirNum = dir === "asc" ? 1 : -1;
  const filtered = links.filter(l => l.slug.toLowerCase().includes(String(q).toLowerCase()) || l.target.toLowerCase().includes(String(q).toLowerCase()));
  const sorted = [...filtered].sort((a,b)=> (a[sort] < b[sort] ? -1 : a[sort] > b[sort] ? 1 : 0) * dirNum);
  res.json(sorted);
});

app.post("/api/links", async (req, res) => {
  const { target, slug } = req.body ?? {};
  if (!target || !isValidUrl(target)) return res.status(400).json({ error: "Adj meg érvényes http(s) URL-t 'target' mezőben." });
  let finalSlug = slug?.trim();
  if (finalSlug && !slugRegex.test(finalSlug)) return res.status(400).json({ error: "A 'slug' 3–32 hosszú, [a-zA-Z0-9_-]." });
  if (!finalSlug) { do { finalSlug = randomSlug(); } while (links.some(l => l.slug === finalSlug)); }
  else if (links.some(l => l.slug === finalSlug)) return res.status(409).json({ error: "Ez a slug már foglalt." });
  const link = { id: crypto.randomUUID(), slug: finalSlug, target: target.trim(), createdAt: Date.now(), clicks: 0 };
  links.push(link); await saveLinks(links);
  res.status(201).json({ ...link, shortUrl: shortUrlFromReq(req, link.slug) });
});

app.get("/api/links/:id", (req, res) => {
  const link = links.find(l => l.id === req.params.id);
  if (!link) return res.status(404).json({ error: "Nincs ilyen link." });
  res.json({ ...link, shortUrl: shortUrlFromReq(req, link.slug) });
});

app.patch("/api/links/:id", async (req, res) => {
  const link = links.find(l => l.id === req.params.id);
  if (!link) return res.status(404).json({ error: "Nincs ilyen link." });
  const { target, slug } = req.body ?? {};
  if (typeof target !== "undefined") { if (!isValidUrl(target)) return res.status(400).json({ error: "Érvénytelen URL." }); link.target = target.trim(); }
  if (typeof slug !== "undefined") { const s = String(slug).trim(); if (!slugRegex.test(s)) return res.status(400).json({ error: "A 'slug' 3–32 hosszú, [a-zA-Z0-9_-]." }); if (links.some(l => l.slug === s && l.id !== link.id)) return res.status(409).json({ error: "Ez a slug már foglalt." }); link.slug = s; }
  await saveLinks(links);
  res.json({ ...link, shortUrl: shortUrlFromReq(req, link.slug) });
});

app.delete("/api/links/:id", async (req, res) => {
  const before = links.length; links = links.filter(l => l.id !== req.params.id);
  if (links.length === before) return res.status(404).json({ error: "Nincs ilyen link." });
  await saveLinks(links); res.status(204).end();
});

app.get("/r/:slug", (req, res) => {
  const link = links.find(l => l.slug === req.params.slug);
  if (!link) return res.status(404).send("Nem található rövid link.");
  link.clicks += 1; saveLinks(links).catch(()=>{});
  res.redirect(302, link.target);
});

app.get("/", (_req, res) => res.send("URL Shorty Backend fut."));

app.listen(PORT, () => { console.log(`Backend: http://localhost:${PORT}`); console.log(`API: http://localhost:${PORT}/api`); });
