# Groundwork Security & Compliance

Marketing site for **Groundwork Security & Compliance**.

- Launch domain: [groundworksec.com](https://groundworksec.com) — **Connected** on Firebase Hosting (apex is live)
- Inbox: [jon@groundworksec.com](mailto:jon@groundworksec.com)
- Code: [github.com/jwelzbacher/groundwork-security](https://github.com/jwelzbacher/groundwork-security)
- Fallback URL: [groundwork-security.web.app](https://groundwork-security.web.app)

**www does not redirect yet.** [`www.groundworksec.com`](https://www.groundworksec.com) resolves and has a valid cert, but returns Firebase’s **404 “Site Not Found”**. Fix it with a Cloudflare redirect rule, not a Firebase custom domain — see below. Do not use [`groundworksecurity.com`](https://groundworksecurity.com) — that name is someone else’s Namecheap parking page.

Desired later: `groundworksecurity.com` is **already registered** at Namecheap (2026-04-10 → 2027-04-10), privacy-protected. We did not register it. See “Acquiring groundworksecurity.com” below.

Static files live in `public/` and deploy to Firebase Hosting. **groundworksec.com** is registered at Cloudflare (nameservers `emily.ns.cloudflare.com`, `igor.ns.cloudflare.com`). Email is **Google Workspace**.

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

## Custom domain status

| Hostname | Status |
|---|---|
| `groundworksec.com` | **Connected.** Serves this site over HTTPS (Google Trust Services). Ownership TXT `hosting-site=groundwork-security` is live. |
| `www.groundworksec.com` | DNS + TLS work, but Firebase does **not** recognize the Host header, so it returns the platform “Site Not Found” page — not this repo’s `public/404.html`. Needs a Cloudflare redirect rule. |
| `groundwork-security.web.app` | Fallback. Same deploy as the apex. |

Both hostnames are **orange-cloud (proxied)**, so public DNS answers with Cloudflare anycast IPs (`104.21.36.20`, `172.67.183.213`) instead of Firebase’s `199.36.158.100`. Cloudflare terminates TLS for both — the `*.groundworksec.com` cert on `www` is Cloudflare Universal SSL, which is issued by Google Trust Services and is easy to mistake for Firebase’s.

## Finish www with a Cloudflare redirect, not Firebase

Adding `www` as a Firebase custom domain **fails on purpose here**. Firebase runs an ACME HTTP-01 check against `http://www.groundworksec.com/.well-known/acme-challenge/...`; Cloudflare 301s it to HTTPS and forwards to Firebase, which 404s because `www` is not attached. That is a loop, and it is what the console reports:

```
Hosting's HTTP GET request for the ACME challenge failed:
104.21.36.20: 404 Not Found, 172.67.183.213: 404 Not Found, ...
```

Firebase needs a cert for any hostname it answers on, even a pure redirect, so its **Redirect** option cannot dodge this. Because Cloudflare already serves `www` with a valid cert, do the redirect at Cloudflare's edge and leave Firebase out of it.

### 1. Cloudflare: one redirect rule

[Cloudflare](https://dash.cloudflare.com) → **Rules → Redirect Rules → Create rule**:

- If **Hostname** equals `www.groundworksec.com`
- Then **Static redirect**, status **301**, to `https://groundworksec.com`

Use a **Dynamic redirect** with expression `concat("https://groundworksec.com", http.request.uri.path)` if you want deep links to keep their path.

Keep `www` **orange-cloud** — the rule only runs when Cloudflare is proxying. Do not delete the `www` A/AAAA records, and do not touch the apex.

### 2. Firebase: drop the pending www domain

In [Firebase Hosting](https://console.firebase.google.com/project/groundwork-security/hosting), **delete** the `www.groundworksec.com` custom domain so it stops retrying ACME. The apex stays Connected; keep its TXT `hosting-site=groundwork-security` forever so Firebase can renew that cert.

### 3. Confirm

```bash
curl -sI https://groundworksec.com | head -5
# expect HTTP/2 200

curl -sI https://www.groundworksec.com | head -8
# expect 301 Location: https://groundworksec.com/
# not 404 and not Firebase "Site Not Found"
```

Grey-clouding `www` is the alternative path if you ever do want Firebase to serve it directly: point `www` at `199.36.158.100` as **DNS only**, let ACME pass, then re-enable the proxy. The redirect rule above is simpler and needs no DNS change.

Keep MX, TXT, and verification records grey.

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
