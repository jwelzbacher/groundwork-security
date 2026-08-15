# Groundwork Security & Compliance

Marketing site for **Groundwork Security & Compliance**.

- Site: [groundworksecurity.com](https://groundworksecurity.com)
- Inbox: [jon@groundworksecurity.com](mailto:jon@groundworksecurity.com)
- Code: [github.com/jwelzbacher/groundwork-security](https://github.com/jwelzbacher/groundwork-security)

Static files live in `public/` and deploy to Firebase Hosting. The domain is registered and DNS-hosted at **Cloudflare**. Email is **Google Workspace**.

## Local preview

```bash
python3 -m http.server 8080 --directory public
```

Open [http://localhost:8080](http://localhost:8080).

## Contact form

The form posts to [FormSubmit](https://formsubmit.co) at `jon@groundworksecurity.com`.

The first live submission sends a confirmation to that mailbox. Confirm it once. If FormSubmit is blocked, the page falls back to a `mailto:` draft.

Do not send a test inquiry until the Workspace user exists and MX is live.

## Firebase Hosting

Project ID: `groundwork-security`

```bash
firebase login
firebase use groundwork-security
firebase deploy --only hosting
```

Hosting does not need Cloud Domains. Link GCP billing only if Firebase asks (Blaze). Spark can serve the `web.app` URL.

## Cloudflare: buy the domain

1. Sign in at [dash.cloudflare.com](https://dash.cloudflare.com) (create an account if needed).
2. **Domain Registration** → search `groundworksecurity.com` → purchase (enable WHOIS privacy).
3. Cloudflare becomes registrar **and** DNS. Nameservers will be the two Cloudflare nameservers shown on the domain’s Overview page. If you bought elsewhere first, point the registrar NS to those Cloudflare nameservers instead.
4. Open **DNS** → **Records**. Leave the zone on the free plan. You will add Firebase and Workspace records here.

## Firebase custom domain (after Cloudflare owns DNS)

In [Firebase Hosting](https://console.firebase.google.com/project/groundwork-security/hosting):

1. **Add custom domain** → `groundworksecurity.com`, then add `www.groundworksecurity.com`.
2. Copy the TXT / A / AAAA / CNAME values Firebase shows. Do not invent IPs.
3. In Cloudflare DNS, create those records with **Proxy status = DNS only** (grey cloud). Orange-cloud proxy often breaks Firebase’s SSL/ownership check.
4. Wait for Firebase to show Connected. After the cert is issued, you can optionally orange-cloud the A/CNAME records; keep MX, TXT, and verification records grey.

Typical shape (values come from Firebase, not this file):

| Type | Name | Value | Proxy |
|---|---|---|---|
| TXT | `@` or Firebase host | ownership token | DNS only |
| A / AAAA | `@` | Firebase IPs | DNS only until connected |
| CNAME | `www` | Firebase host | DNS only until connected |

## Google Workspace MX (after jon@ is created)

Create the Workspace account for `groundworksecurity.com`, add user `jon`, then in Cloudflare DNS:

| Type | Name | Priority | Value | Proxy |
|---|---|---|---|---|
| MX | `@` | 1 | `aspmx.l.google.com` | DNS only |
| MX | `@` | 5 | `alt1.aspmx.l.google.com` | DNS only |
| MX | `@` | 5 | `alt2.aspmx.l.google.com` | DNS only |
| MX | `@` | 10 | `alt3.aspmx.l.google.com` | DNS only |
| MX | `@` | 10 | `alt4.aspmx.l.google.com` | DNS only |
| TXT | `@` | — | `v=spf1 include:_spf.google.com ~all` | DNS only |
| TXT | `@` | — | Workspace domain-verification string from the Admin console | DNS only |
| CNAME | Google DKIM host | — | Google DKIM target from the Admin console | DNS only |

Do not orange-cloud MX or TXT. After MX propagates, send a test to `jon@groundworksecurity.com`.

Optional DMARC (after SPF + DKIM pass):

| Type | Name | Value |
|---|---|---|
| TXT | `_dmarc` | `v=DMARC1; p=none; rua=mailto:jon@groundworksecurity.com` |

## GitHub push (no keys in chat)

CLI token on this machine is expired. When you are at the laptop:

```bash
gh auth login -h github.com -p https -w
```

Complete the browser flow, then from this repo:

```bash
cd /Users/jon/groundwork-security
git push origin main
```

Do not paste a PAT or SSH private key into chat. Rotate anything that was ever shared in plaintext.

## Stack

- Static HTML / CSS / JS (no build step)
- Fonts: Fraunces + Outfit
- Portrait: `public/images/jon-welzbacher.png`
