# Optional: Cursor Automation after a PR

The in-Cursor button is `/deploy-firebase-hosting`. Use an automation only if you also want GitHub to start that same Cloud Agent.

Create it yourself at [cursor.com/automations](https://cursor.com/automations) (or with `/automate` in a local Agent). This repository cannot register the automation.

Recommended setup so it still behaves like a button, not an auto-launch:

1. Repository: `jwelzbacher/groundwork-security`
2. Environment: the existing Cloud Agent environment for this repo
3. Trigger: **Comment added** on a pull request
4. Filter: comment body matches `/deploy` (or `deploy-firebase-hosting`)
5. Tools: Comment on pull request
6. Prompt (paste):

```text
You are the post-merge Firebase Hosting deployer for github.com/jwelzbacher/groundwork-security.

Only continue if this run was started by an explicit /deploy comment (or an equivalent explicit invoke of /deploy-firebase-hosting). Follow the project skill at .cursor/skills/deploy-firebase-hosting/SKILL.md.

Rules:
- Deploy Firebase Hosting only, project groundwork-security, public/ as configured in firebase.json.
- If the PR is not merged into main, do not deploy. Reply on the PR that it must be merged first.
- If FIREBASE_SERVICE_ACCOUNT (or GOOGLE_APPLICATION_CREDENTIALS / FIREBASE_TOKEN) is missing, do not deploy. Comment that the Runtime Secret must be added on the Cloud Agent environment. Never ask for the JSON in the PR or in chat.
- After a successful deploy, comment the commit SHA and https://groundwork-security.web.app
- Never deploy Functions, Rules, Storage, or other Firebase products.
- Never buy domains or change DNS.
```

If you later want fully automatic deploys, add a second trigger **Pull request merged** into `main` and keep the same prompt. Do not enable that until you are ready to publish on every merge.

The automation still needs the `FIREBASE_SERVICE_ACCOUNT` Runtime Secret on the environment. GitHub access does not grant Firebase deploy rights.
