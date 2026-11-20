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
HEAD
    case "$page" in
      sprint) title="Skier or IKEA-r? Sprint"; desc="Race the World Cup sprint field: is each name a ski racer or an IKEA product? Fastest correct answers win."; url="https://velogordo.github.io/skier-or-ikear/sprint.html" ;;
      *) title="Skier or IKEA-r?"; desc="Is it a cross-country ski racer or an IKEA product? 7 names. How many can you get?"; url="https://velogordo.github.io/skier-or-ikear/" ;;
    esac
    cat <<META
<meta name="description" content="$desc">
<meta property="og:type" content="website">
<meta property="og:title" content="$title">
<meta property="og:description" content="$desc">
<meta property="og:url" content="$url">
<meta property="og:image" content="https://velogordo.github.io/skier-or-ikear/og.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta name="twitter:card" content="summary_large_image">
META
    cat <<'GC'
<script data-goatcounter="https://skier-or-ikear.goatcounter.com/count" async src="//gc.zgo.at/count.js"></script>
GC
    cat <<'HEAD'
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
cp og.png docs/og.png
touch docs/.nojekyll
echo "Built docs/index.html, docs/sprint.html, docs/data.js, docs/og.png"
