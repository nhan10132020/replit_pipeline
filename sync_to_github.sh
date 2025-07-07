#!/bin/bash
set -e

# Set up GitHub credentials
GITHUB_REPO="https://${GH_TOKEN}@github.com/nhan10132020/replit_pipeline.git"

git config --global user.email "asol@automate-solutions.net"
git config --global user.name "CI Sync Bot"

git init 
git add .
git commit -m "Sync changes from GitLab CI" || true
git remote add github $GITHUB_REPO || true
git push github main --force
