# Groundwork client reports

Letter-size attestation reports branded with the Groundwork kit (Soil / Clay / Paper, Fraunces + Outfit). These files are **not** deployed to Firebase Hosting. Keep them out of `public/`.

This GitHub repository is public. Treat client letters as work product you may later move to a private store.

## Nurseplexus — HIPAA letter of attestation

- Source: `hipaa-letter-of-attestation/index.html`
- PDF: `Groundwork-HIPAA-Letter-of-Attestation-Nurseplexus.pdf`

Preview:

```bash
python3 -m http.server 8080 --directory . --bind 127.0.0.1
```

Open [http://127.0.0.1:8080/reports/hipaa-letter-of-attestation/](http://127.0.0.1:8080/reports/hipaa-letter-of-attestation/).

Regenerate the PDF:

```bash
./scripts/export-hipaa-report.sh
```
