#!/bin/bash
# Offline asset maintenance only; the website itself has no build step.
set -euo pipefail
app_source="${1:?Usage: tools/export-previews.sh /path/to/PaperBirdsScreenSaver}"
site_root="$(cd "$(dirname "$0")/.." && pwd)"
capture_dir="$(mktemp -d "${TMPDIR:-/tmp}/paperbirds-web.XXXXXX")"
bundle="$capture_dir/Capture.app/Contents"
mkdir -p "$bundle/MacOS" "$bundle/Resources" "$capture_dir/output"
cp "$app_source/Sources/PaperBirdsPrototype/Shaders.metal" "$app_source/Sources/PaperBirdsPrototype/MoonReference.png" "$bundle/Resources/"
xcrun swiftc -module-cache-path "$capture_dir/module-cache" -swift-version 5 -O -parse-as-library -D HOST_SMOKE -D MEDIA_EXPORT \
  "$app_source"/Sources/FlightCore/*.swift "$app_source/Sources/PaperBirdsPrototype/Renderer.swift" \
  "$site_root/tools/export-previews.swift" -o "$bundle/MacOS/Capture"
for shot in \
  'forest,expanded,chase,summer,12' \
  'city2-chase,city2,chase,summer,40' \
  'city2-overhead,city2,overhead,summer,40' \
  'classic,classic,cinematic,summer,24' \
  'city,city,chase,summer,24' \
  'village,village2,cinematic,summer,24' \
  'winter,expanded,chase,winter,24'; do
  "$bundle/MacOS/Capture" video "$capture_dir/output" "$shot"
done
mkdir -p "$site_root/paperbirds/videos" "$site_root/paperbirds/images"
cp "$capture_dir/output/"*.mp4 "$site_root/paperbirds/videos/"
cp "$capture_dir/output/"*.jpg "$site_root/paperbirds/images/"
printf 'Exported previews. Temporary source frames retained at: %s\n' "$capture_dir"
