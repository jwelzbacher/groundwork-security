# Groundwork Security & Compliance

Marketing site for **Groundwork Security & Compliance** — modern security and compliance for small and midsize businesses that need SOC 2, HITRUST, ISO 27001, or FedRAMP without a full-time security hire.

This repository is a static site in `public/`, ready for Firebase Hosting.

## Local preview

```bash
cd public
python3 -m http.server 8080
```

Open [http://localhost:8080](http://localhost:8080).

## Contact form

The form posts to [FormSubmit](https://formsubmit.co) at `jonwelzbacher@gmail.com`.

The first live submission sends a confirmation email to that inbox. Click the confirm link once, then submissions will arrive as usual. If FormSubmit is blocked, the page falls back to a `mailto:` draft.

## Firebase (next prompt)

1. `firebase login`
2. `firebase projects:create groundwork-security` (or attach an existing GCP project)
3. Update `.firebaserc` if the project ID differs
4. `firebase deploy --only hosting`

Default hosting URL will look like `https://groundwork-security.web.app` until a custom domain is added.

## Stack

- Static HTML / CSS / JS (no build step)
- Fonts: Fraunces + Outfit
- Portrait: `public/images/jon-welzbacher.png`
