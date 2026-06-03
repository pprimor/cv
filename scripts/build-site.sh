#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf dist
mkdir -p dist

cp index.html favicon.svg dist/
cp CV.pdf CV_pt.pdf dist/
[ -f cover_letter.pdf ] && cp cover_letter.pdf dist/
cp scripts/_headers dist/_headers
