#!/bin/bash

ruby --version

mkdir -p _site .jekyll-cache  # Required due to some file permission issue
chmod -R 777 _site .jekyll-cache Gemfile.lock

bundle install
bundle exec ./bin/validate_resume.rb

if [[ "${GITHUB_REF_NAME}" == "main" ]]; then
  bundle exec jekyll build
else
  bundle exec jekyll build --drafts $@
fi
