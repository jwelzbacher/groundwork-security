# Groundwork Security & Compliance

Marketing site for **Groundwork Security & Compliance**.

- Launch domain: [groundworksec.com](https://groundworksec.com) — purchased, Cloudflare registrar + DNS
- Inbox: [jon@groundworksec.com](mailto:jon@groundworksec.com)
- Code: [github.com/jwelzbacher/groundwork-security](https://github.com/jwelzbacher/groundwork-security)
- Live now (until Firebase shows Connected): [groundwork-security.web.app](https://groundwork-security.web.app)

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

## Attach groundworksec.com to Firebase Hosting

Cloudflare already owns the zone. There are no A / AAAA / TXT records yet. Add the domain in Firebase, then paste the records below in Cloudflare **DNS → Records**.

### 1. Firebase: add the custom domain

In [Firebase Hosting](https://console.firebase.google.com/project/groundwork-security/hosting) for project `groundwork-security`:

1. **Add custom domain** → `groundworksec.com`.
2. Check **Redirect** so `www.groundworksec.com` goes to the apex (or add `www` as a second domain).
3. Use **Quick setup** (the domain is not serving traffic yet).
4. Copy the ownership **TXT** value the wizard shows. Keep that TXT forever so Firebase can renew the cert.

### 2. Cloudflare DNS for Firebase (all DNS only)

Open [Cloudflare DNS for groundworksec.com](https://dash.cloudflare.com). Create these records with **Proxy status = DNS only** (grey cloud). Orange-cloud proxy answers with Cloudflare IPs, and Firebase’s ownership / SSL check then fails because it cannot see its own address.

Firebase’s documented Cloudflare shape ([Connect a custom domain](https://firebase.google.com/docs/hosting/custom-domain)):

| Type | Name | Value | Proxy |
|---|---|---|---|
| TXT | `@` | ownership token from the Firebase wizard | DNS only |
| A | `@` | `199.36.158.100` | DNS only |
| A | `www` | `199.36.158.100` | DNS only |

If the wizard also prints AAAA records or a different A, use those values instead of this table. Do not add extra A/AAAA records that Firebase did not show.

TTL: Auto. Leave any Cloudflare parking / “under construction” A records deleted so only Firebase’s `199.36.158.100` answers.

### 3. Confirm Connected

```bash
dig +short A groundworksec.com
# expect 199.36.158.100

dig +short A www.groundworksec.com
# expect 199.36.158.100

dig +short TXT groundworksec.com
# expect the Firebase ownership token
```

Firebase status should move Needs setup → Pending / Minting Certificate → **Connected** (often minutes, up to 24 hours). After Connected, `https://groundworksec.com` serves this site with a Google-provisioned cert.

Keep MX, TXT, and verification records grey. After Connected you may orange-cloud the A records if you want Cloudflare in front; grey is the safer default.

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

## Stack

- Static HTML / CSS / JS (no build step)
- Fonts: Fraunces + Outfit
- Portrait: `public/images/jon-welzbacher.png`
