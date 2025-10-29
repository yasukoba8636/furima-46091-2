#!/usr/bin/env bash
# exit on error
set -o errexit
export RAILS_ENV=production
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# 初回デプロイ時にDBがない場合、自動で作成＆マイグレーション
bundle exec rake db:prepare
