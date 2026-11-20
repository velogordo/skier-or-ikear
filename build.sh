#!/bin/sh
# Wraps index.html (written as a Claude artifact body) into a full standalone
# page at docs/index.html, which GitHub Pages serves. Run after editing the game.
# The lines above the first <style> (title, meta, font links) move into <head>.
set -e
cd "$(dirname "$0")"
mkdir -p docs
{
  cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="description" content="Seven names. Is each one a cross-country ski racer or an IKEA product?">
<style>
:root { color-scheme: light; padding-top: env(safe-area-inset-top, 0px); padding-bottom: env(safe-area-inset-bottom, 0px); }
body { margin: 0; font: 14px/1.4 system-ui, -apple-system, "Segoe UI", sans-serif; }
img { max-width: 100%; }
[hidden] { display: none !important; }
</style>
HEAD
  awk '/<style>/ { exit } { print }' index.html
  printf '</head>\n<body>\n'
  awk 'f || /<style>/ { f = 1; print }' index.html
  printf '</body>\n</html>\n'
} > docs/index.html
touch docs/.nojekyll
echo "Built docs/index.html"
