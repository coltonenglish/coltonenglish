#!/bin/bash
set -e

# Ruby version for debugging
ruby --version

# Required due to some file permission issue
mkdir -p _site .jekyll-cache

# Install dependencies if Gemfile exists
if [ -f "Gemfile" ]; then
  bundle install
fi

# Determine if we should build drafts
if [[ "${GITHUB_REF_NAME}" == "main" ]]; then
  bundle exec jekyll build
else
  bundle exec jekyll build --drafts
fi
