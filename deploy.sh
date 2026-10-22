#!/bin/sh
# Fetch the latest plab-ann-proxy from GitHub and (re)build + start it, for hosts without git.
# Run it from the directory that holds your .env (e.g. UI_PASSWORD=...) and ./data; re-run to update.
set -eu
DIR="${DEPLOY_DIR:-$HOME/Server/plab-ann-proxy}"
mkdir -p "$DIR/src" && cd "$DIR"
rm -rf src/* && curl -fsSL https://github.com/gauravsuman007/plab-ann-proxy/archive/refs/heads/main.tar.gz \
  | tar -xz -C src --strip-components=1
cd src
# keep config and data outside src/ so an update never touches them
[ -f ../.env ] && ln -sf ../.env .env
mkdir -p ../data && ln -sfn ../data data
docker compose up -d --build
