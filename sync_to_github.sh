#!/bin/bash
set -e

# Set up GitHub credentials
GITHUB_REPO="https://${GH_TOKEN}@github.com/nhan10132020/replit_pipeline.git"

git config --global user.email "asol@automate-solutions.net"
git config --global user.name "CI Sync Bot"

# Initialize (safe if already exists)
git init

# Check if we're in detached HEAD and create main branch
git checkout -b main || git checkout main

# Add + commit
git add .
git commit -m "Sync changes from GitLab CI" || true

# Add GitHub remote (safe if exists)
git remote add github $GITHUB_REPO || true

# Push to GitHub
git push github main --force
