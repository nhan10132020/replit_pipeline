#!/bin/bash
set -e

GITHUB_REPO="https://${GH_TOKEN}@github.com/nhan10132020/replit_pipeline.git"

git config --global user.email "ci-bot@example.com"
git config --global user.name "GitLab CI Bot"

# Ensure we're in a real branch
git checkout -B main

# Always create a dummy file to ensure something changes
echo "Synced at $(date)" > .sync_timestamp
git add .sync_timestamp

# Optional: add all changes, not just the dummy file
git add .

git commit -m "Sync from GitLab CI at $(date)" || echo "No changes to commit"

# Add remote safely
git remote add github $GITHUB_REPO || true

# Push
git push github main --force
