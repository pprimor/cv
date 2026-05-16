#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

rm -rf dist
mkdir -p dist

cp index.html Icons8-Windows-8-Very-Basic-Document.ico dist/
cp CV.pdf CV_pt.pdf dist/
[ -f cover_letter.pdf ] && cp cover_letter.pdf dist/
cp scripts/_headers dist/_headers
