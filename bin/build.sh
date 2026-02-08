#!/bin/bash

ruby --version

# Fix permissions for Gemfile.lock as some environments try to update it
[ -f Gemfile.lock ] && chmod a+w Gemfile.lock

mkdir -p _site .jekyll-cache  # Required due to some file permission issue

if [[ "${GITHUB_REF_NAME}" == "main" ]]; then
  jekyll build
else
  jekyll build --drafts $@
fi
