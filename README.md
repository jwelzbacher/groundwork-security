# Groundwork Security & Compliance

Marketing site for **Groundwork Security & Compliance**.

- Launch domain: [groundworksec.com](https://groundworksec.com) — **Connected** on Firebase Hosting (apex is live)
- Inbox: [jon@groundworksec.com](mailto:jon@groundworksec.com)
- Code: [github.com/jwelzbacher/groundwork-security](https://github.com/jwelzbacher/groundwork-security)
- Fallback URL: [groundwork-security.web.app](https://groundwork-security.web.app)

**www is not connected yet.** [`www.groundworksec.com`](https://www.groundworksec.com) resolves in DNS and has a valid cert, but Firebase returns **404 “Site Not Found”** because that hostname is not a custom domain on the Hosting site. Add it in Firebase (steps below). Do not use [`groundworksecurity.com`](https://groundworksecurity.com) — that name is someone else’s Namecheap parking page.

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
| `www.groundworksec.com` | DNS + TLS work; Firebase does **not** recognize the Host header. Returns the platform “Site Not Found” page, not this repo’s `public/404.html`. |
| `groundwork-security.web.app` | Fallback. Same deploy as the apex. |

Public A records currently answer with Cloudflare proxy IPs (`104.21.36.20`, `172.67.183.213`), not Firebase’s `199.36.158.100`. That means the records are **orange-cloud (proxied)**. Apex still works because Cloudflare forwards to Firebase and the apex hostname is connected. Orange cloud is why Firebase’s www check often never completes.

## Finish www (the remaining miss)

This cannot be done from the repo. There is no Firebase CLI login or Cloudflare API token here.

### 1. Firebase: add www

In [Firebase Hosting](https://console.firebase.google.com/project/groundwork-security/hosting) for project `groundwork-security`:

1. **Add custom domain** → `www.groundworksec.com`.
2. Choose **Redirect** so `www` goes to `groundworksec.com`.
3. If www is already listed but stuck on Needs setup / Pending, open it and copy any extra TXT / A / AAAA values.
4. Keep the existing apex TXT (`hosting-site=groundwork-security`) forever so Firebase can renew the cert.

### 2. Cloudflare: grey-cloud until Connected

Open [Cloudflare DNS for groundworksec.com](https://dash.cloudflare.com). Set the **www** A record (and the apex A if Firebase still complains) to **DNS only (grey cloud)** until Firebase shows **Connected**.

| Type | Name | Value | Proxy |
|---|---|---|---|
| TXT | `@` | `hosting-site=groundwork-security` (already live) | DNS only |
| A | `@` | `199.36.158.100` | DNS only until Connected |
| A | `www` | `199.36.158.100` | DNS only until Connected |

If the Firebase wizard prints different A/AAAA values, use those instead. Orange-cloud proxy answers with Cloudflare IPs, and Firebase’s www ownership / SSL check then fails because it cannot see its own address.

### 3. Confirm www redirects

```bash
curl -sI https://groundworksec.com | head -5
# expect HTTP/2 200

curl -sI https://www.groundworksec.com | head -8
# expect 301/302 Location: https://groundworksec.com/
# not 404 and not Firebase “Site Not Found”

dig +short A www.groundworksec.com
# while grey: 199.36.158.100
# while orange: Cloudflare anycast (104.x / 172.67.x)
```

Firebase status for www should move Needs setup → Pending / Minting Certificate → **Connected** (often minutes, up to 24 hours).

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
