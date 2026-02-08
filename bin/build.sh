#!/bin/sh
set -e

# Install dependencies if Gemfile exists
if [ -f "Gemfile" ]; then
  bundle install
fi

# Build the site
bundle exec jekyll build
