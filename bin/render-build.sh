#!/usr/bin/env bash
# exit on error
set -o errexit

echo "=== Installing gems ==="
bundle install

echo "=== Cleaning old assets ==="
bundle exec rails assets:clean RAILS_ENV=production

echo "=== Precompiling assets ==="
bundle exec rails assets:precompile RAILS_ENV=production

echo "=== Preparing database ==="
# DBが存在しない場合は作成、既存の場合はマイグレーション
bundle exec rails db:prepare RAILS_ENV=production

echo "=== Build complete ==="
