---
name: deploy-firebase-hosting
description: Deploy this static site to Firebase Hosting after a pull request is merged. Invoke explicitly with /deploy-firebase-hosting. Never deploy unless this skill is slash-invoked.
disable-model-invocation: true
icon: rocket
color: orange
---

# Deploy Firebase Hosting

Repeatable **after-merge** deploy for the Groundwork marketing site.

This skill is a slash-menu button. Do **not** deploy because a PR exists, because code changed, or because the user mentioned Firebase. Deploy only when the user invoked `/deploy-firebase-hosting` (or an equivalent explicit "run the deploy skill" instruction in this turn).

Do not launch, buy domains, or change DNS as part of this skill.

## Target

- Firebase project: `groundwork-security`
- Product: Hosting only (`firebase.json` → `public/`)
- Live URL: https://groundwork-security.web.app
- Default git ref: `origin/main` at the merge commit

## Procedure

1. Confirm the skill was explicitly invoked this turn. If it was not, stop.
2. Resolve the git ref:
   - If the user named a PR, run `gh pr view <n> --json state,mergedAt,mergeCommit,baseRefName,url` (GitHub CLI is read-only here). Deploy only when `state` is `MERGED` and `baseRefName` is `main`. Check out that merge commit.
   - Otherwise fetch `origin/main` and check out `origin/main`.
   - If the PR is still open, **do not deploy**. Say it must be merged first.
3. Confirm `firebase.json` and `.firebaserc` still point at project `groundwork-security` and hosting public dir `public`.
4. Check credentials without printing them:
   - Prefer Runtime Secret `FIREBASE_SERVICE_ACCOUNT` (full service account JSON) or an already-valid `GOOGLE_APPLICATION_CREDENTIALS` file.
   - `FIREBASE_TOKEN` is a deprecated fallback. Use it only if no service account is present.
   - If none are present, **stop**. Tell the user to add `FIREBASE_SERVICE_ACCOUNT` as a **Runtime Secret** on the Cloud Agent environment ([02a32846-a7a6-11f1-a7d1-d6b4613131ce](https://cursor.com/dashboard/cloud-agents/environments/e/02a32846-a7a6-11f1-a7d1-d6b4613131ce)). The Google Cloud service account needs **Firebase Hosting Admin** on project `groundwork-security`. Do not ask them to paste the JSON into chat.
5. Run the skill script from the repo root. Never `echo`, `cat`, or log credential values.

   ```bash
   bash .cursor/skills/deploy-firebase-hosting/scripts/deploy-hosting.sh
   ```

   For a no-publish rehearsal only (when the user asked for dry-run):

   ```bash
   bash .cursor/skills/deploy-firebase-hosting/scripts/deploy-hosting.sh --dry-run
   ```

6. After a real deploy, confirm Hosting reported a successful release and that https://groundwork-security.web.app serves the expected change. Reply with the project, commit SHA, and live URL.
7. Never deploy Functions, Rules, Storage, or other Firebase products. Never use `--force` except as already encoded in the script for Hosting.

## Optional Cursor Automation

This repo skill is the in-Cursor button (`/` menu, Cloud Agent, or local Agent on `main`).

To also fire from GitHub after a merge, create an automation at [cursor.com/automations](https://cursor.com/automations). Cursor cannot create that from this repository. Copy the prompt in `references/cursor-automation.md`.
