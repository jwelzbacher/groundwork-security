# Groundwork Security & Compliance

Marketing site for **Groundwork Security & Compliance**.

- Launch domain: [groundworksec.com](https://groundworksec.com)
- Inbox: [jon@groundworksec.com](mailto:jon@groundworksec.com)
- Code: [github.com/jwelzbacher/groundwork-security](https://github.com/jwelzbacher/groundwork-security)
- Live now (until custom domain is attached): [groundwork-security.web.app](https://groundwork-security.web.app)

Desired later: `groundworksecurity.com` is **already registered** at Namecheap (2026-04-10 → 2027-04-10), privacy-protected. We did not register it. See “Acquiring groundworksecurity.com” below.

Static files live in `public/` and deploy to Firebase Hosting. Buy **groundworksec.com** at **Cloudflare** (registrar + DNS). Email is **Google Workspace**.

## Local preview

```bash
python3 -m http.server 8080 --directory public
```

Open [http://localhost:8080](http://localhost:8080).

## Contact form

The form posts to [FormSubmit](https://formsubmit.co) at `jon@groundworksec.com`.

The first live submission sends a confirmation to that mailbox. Confirm it once. If FormSubmit is blocked, the page falls back to a `mailto:` draft.

Do not send a test inquiry until the Workspace user exists and MX is live.

## Firebase Hosting

Project ID: `groundwork-security`

```bash
firebase login
firebase use groundwork-security
firebase deploy --only hosting
```

## Cloudflare: buy groundworksec.com

1. Sign in at [dash.cloudflare.com](https://dash.cloudflare.com).
2. **Domain Registration** → search `groundworksec.com` → purchase (WHOIS privacy on).
3. Cloudflare becomes registrar **and** DNS.
4. Open **DNS** → **Records**. Add Firebase and Workspace records here.

## Firebase custom domain (after Cloudflare owns DNS)

In [Firebase Hosting](https://console.firebase.google.com/project/groundwork-security/hosting):

1. **Add custom domain** → `groundworksec.com`, then `www.groundworksec.com`.
2. Copy the TXT / A / AAAA / CNAME values Firebase shows.
3. In Cloudflare DNS, create those records with **Proxy status = DNS only** (grey cloud) until Firebase shows Connected.

## Google Workspace MX (after jon@ is created)

Create Workspace for `groundworksec.com`, add user `jon`, then in Cloudflare DNS (all DNS only):

| Type | Name | Priority | Value |
|---|---|---|---|
| MX | `@` | 1 | `aspmx.l.google.com` |
| MX | `@` | 5 | `alt1.aspmx.l.google.com` |
| MX | `@` | 5 | `alt2.aspmx.l.google.com` |
| MX | `@` | 10 | `alt3.aspmx.l.google.com` |
| MX | `@` | 10 | `alt4.aspmx.l.google.com` |
| TXT | `@` | — | `v=spf1 include:_spf.google.com ~all` |
| TXT | `@` | — | Workspace verification string from Admin |
| CNAME | DKIM host from Admin | — | DKIM target from Admin |

Optional later: `_dmarc` TXT `v=DMARC1; p=none; rua=mailto:jon@groundworksec.com`

## Acquiring groundworksecurity.com

Do not wait only on expiry. It is paid through **April 10, 2027**, so drop-catching is a long shot.

Ways to reach the owner without public WHOIS:

1. **Namecheap aftermarket / Afternic** — search the domain; some Namecheap names are listed for sale.
2. **Sedo brokered offer** — WHOIS.com already offered a Sedo “make offer” path. A low four-figure offer is typical for an unused brandable; ignore if they want five figures.
3. **Privacy contact** — Namecheap Withheld for Privacy still forwards messages. Use Namecheap’s “Contact domain owner” / WHOIS inquiry form, not a guessed email.
4. **Expiry watch** — set a reminder for early 2027 (Namecheap often auto-renews). Treat this as backup, not the plan.

If you get the long name later, keep `groundworksec.com` and 301 it to `groundworksecurity.com`.

## GitHub push (no keys in chat)

```bash
gh auth login -h github.com -p https -w
cd /Users/jon/groundwork-security
git push origin main
```

## Brand kit

Canonical identity lives at [`/brand`](https://groundworksec.com/brand) and in `public/brand/kit/`.

- Interactive book (print to PDF): `public/brand/index.html`
- Vectors, tokens, Claude Design pack: `public/brand/kit/`
- Agent-readable system: `DESIGN.md` at the repo root

Local preview of the book: open [http://localhost:8080/brand](http://localhost:8080/brand). Use **Download PDF** for the Drive-ready file (`public/brand/kit/Groundwork-Brand-Guide.pdf`), or regenerate:

```bash
./scripts/export-brand-kit.sh
```

Upload `Groundwork-Brand-Guide.pdf` plus `DESIGN.md` and `logos/svg/` to Claude Design and to a Google Drive folder named **Groundwork Brand**. See `public/brand/kit/README.md`.

## Stack

- Static HTML / CSS / JS (no build step)
- Fonts: Fraunces + Outfit
- Portrait: `public/images/jon-welzbacher.png`
