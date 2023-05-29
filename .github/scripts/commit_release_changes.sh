#!/bin/sh
set -e

git config remote.origin.url "https://$TOKEN@github.com/$GITHUB_REPOSITORY"

git config --global user.email "github-actions@github.com"
git config --global user.name "$GITHUB_ACTOR"
git checkout $BRANCH

if [ -z "$(git status --porcelain)" ]; then
  echo "No changes detected"
else
  git status
  echo "Adding git commit"
  git add -A
  git commit --message "[BUILD] $TAG"
  git push --force-with-lease
fi
