# Digital Chant Stand — Strană Digitală

A mobile-first liturgical tool for the Romanian Orthodox parish of Ss. Brendan the Navigator & Joseph the New of Partos, Dublin, Ireland.

Built on Cloudflare Pages + Workers + D1 (free tier).

## Prerequisites

- Node.js 18+ and npm
- Cloudflare account (free tier is sufficient)
- Wrangler CLI: `npm install -g wrangler`

## Initial Setup

```bash
# 1. Authenticate with Cloudflare
wrangler login

# 2. Clone/download, then install dev dependencies
cd chant-stand
npm install

# 3. Create the D1 database
wrangler d1 create chant_stand_db
# Copy the database_id from the output and paste it into wrangler.toml

# 4. Create KV namespace
wrangler kv:namespace create SESSIONS
# Copy the namespace ID into wrangler.toml
```

## Secrets

```bash
# Set the Choir Lead editing password
wrangler secret put EDITOR_PASSWORD
# Enter a strong password when prompted

# Set the JWT signing secret
wrangler secret put JWT_SECRET
# Enter a random 32+ character string when prompted
```

## Database Migration

```bash
# Run the migration (creates tables + seeds liturgy data)
wrangler d1 execute chant_stand_db --file=migrations/0001_initial.sql

# Verify it worked
wrangler d1 execute chant_stand_db --command="SELECT COUNT(*) FROM liturgy_blocks"
# Should return ~100+ rows
```

## Local Development

```bash
# 1. Create .dev.vars with your secrets (already templated)
#    Edit .dev.vars and set real values for EDITOR_PASSWORD and JWT_SECRET

# 2. Run the local D1 migration
npm run migrate:local

# 3. Start the dev server
npm run dev

# 4. Visit http://localhost:8788
```

## Deployment

```bash
# Deploy to Cloudflare Pages
npm run deploy
# or: wrangler pages deploy public

# Site goes live at: https://chant-stand.pages.dev
```

## Custom Domain (optional)

1. Go to Cloudflare Dashboard > Pages > chant-stand > Custom Domains
2. Add your domain (e.g. `strana.yourparish.ie`)
3. Update DNS as instructed by Cloudflare

## Updating Liturgy Texts

1. Open the app on any device
2. Tap the ✏️ Edit button in the header
3. Enter the Choir Lead password
4. Click any text block to edit it
5. Click **Save** when finished — changes persist to the database
6. Click **Exit** to leave edit mode

## Architecture

```
public/          Static SPA (HTML, CSS, JS)
functions/api/   Cloudflare Pages Functions (API endpoints)
migrations/      D1 database schema and seed data
```

All liturgy text is stored in D1 (SQLite) and fetched via API on demand. The service worker caches responses for offline use during services.

## Cost

Runs entirely on Cloudflare's free tier: €0/month.
