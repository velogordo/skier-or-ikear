#!/bin/sh
# Wraps each game page (written as a Claude artifact body) into a full standalone
# page in docs/, which GitHub Pages serves, and copies the shared data file.
# Run after editing the game. The lines above each page's first <style>
# (title, meta, font links) move into <head>.
set -e
cd "$(dirname "$0")"
mkdir -p docs
for page in index sprint; do
  {
    cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="description" content="Is it a cross-country ski racer or an IKEA product? A quick phone game, with a sprint mode against the World Cup field.">
<style>
:root { color-scheme: light; padding-top: env(safe-area-inset-top, 0px); padding-bottom: env(safe-area-inset-bottom, 0px); }
body { margin: 0; font: 14px/1.4 system-ui, -apple-system, "Segoe UI", sans-serif; }
img { max-width: 100%; }
[hidden] { display: none !important; }
</style>
HEAD
    awk '/<style>/ { exit } { print }' "$page.html"
    printf '</head>\n<body>\n'
    awk 'f || /<style>/ { f = 1; print }' "$page.html"
    printf '</body>\n</html>\n'
  } > "docs/$page.html"
done
cp data.js docs/data.js
touch docs/.nojekyll
echo "Built docs/index.html, docs/sprint.html, docs/data.js"
