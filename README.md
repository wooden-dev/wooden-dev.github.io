# WoodenDev website

A lightweight, multi-product website for WoodenDev, with a dedicated Paper Birds
marketing page, support page, and privacy policy. Plain HTML and shared CSS;
no build step, package manager, cookies, analytics, or external fonts. A small local JavaScript file manages visible video playback and reduced-motion preferences.
The Paper Birds application repository was inspected read-only and not modified.

## Directory structure

```text
.
├── .nojekyll
├── README.md
├── index.html
├── css/style.css
├── js/previews.js
├── images/favicon.svg
├── tools/
│   ├── export-previews.sh
│   └── export-previews.swift
└── paperbirds/
    ├── index.html
    ├── support/index.html
    ├── privacy/index.html
    ├── images/
    │   ├── app-icon.png
    │   └── {classic,forest,city,city2-chase,city2-overhead,village,winter}.jpg
    └── videos/
        └── {classic,forest,city,city2-chase,city2-overhead,village,winter}.mp4
```

The root represents WoodenDev. Each product uses `/<product>/`,
`/<product>/support/`, and `/<product>/privacy/` relative to the site's base URL.
These are site-relative routes, not assumptions about the domain root.
Links in HTML are document-relative so a GitHub project-site prefix works.

## Preview locally

From this repository, run:

```sh
python3 -m http.server 8765 --bind 127.0.0.1
```

Open `http://127.0.0.1:8765/`, then `/paperbirds/`, `/paperbirds/support/`,
and `/paperbirds/privacy/`. Stop the server with Ctrl+C. No build is required.

## Deployment status and actual production URLs

**Not deployed; no verified production URL as of 23 September 2026.**

Read-only GitHub API checks established:

- Repository: `wooden-dev/woodendev.github.io`, public, default branch `main`.
- Repository response: `has_pages: false`.
- Pages configuration endpoint: HTTP 404; no published `html_url` returned.
- The currently authenticated CLI account has pull access, but no push or admin
  permission. Publishing and changing Pages settings require an authorized account.
- No repository was renamed or created. No deployment was performed.

| Page | Actual production URL | Submission status |
| --- | --- | --- |
| WoodenDev | Not yet assigned/verified | Not deployed |
| Paper Birds marketing | Not yet assigned/verified | NOT READY |
| Paper Birds support | Not yet assigned/verified | NOT READY |
| Paper Birds privacy | Not yet assigned/verified | NOT READY |

Under GitHub's default project-site rules, the **expected, unverified** base is
`https://wooden-dev.github.io/woodendev.github.io/`. With that base, expected routes are:

- Marketing: `https://wooden-dev.github.io/woodendev.github.io/paperbirds/`
- Support: `https://wooden-dev.github.io/woodendev.github.io/paperbirds/support/`
- Privacy: `https://wooden-dev.github.io/woodendev.github.io/paperbirds/privacy/`

Do not submit these until GitHub reports the actual URL and public HTTPS checks pass.
A user site for `wooden-dev` requires a repository named `wooden-dev.github.io`,
which would give `https://wooden-dev.github.io/`, not `https://woodendev.github.io/`.
The requested current repository can be used as a project site without renaming it.
A rename or new repository requires the owner's explicit approval.
See [GitHub's site types and URL rules](https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages).

### Exact Pages settings

After resolving release TODOs and pushing the site to `main` using an account with write access:

1. Open this repository's **Settings → Pages**.
2. Under **Build and deployment**, select **Deploy from a branch**.
3. Select branch **main**, folder **/ (root)**, and **Save**.
4. Leave **Custom domain** empty unless a separately verified domain is intended.
5. Enable **Enforce HTTPS** when available.
6. Wait for GitHub to report the published URL. No custom GitHub Actions workflow is
   necessary. `.nojekyll` lets GitHub serve these static files directly.
7. Query `gh api repos/wooden-dev/woodendev.github.io/pages` and record its `html_url`.
8. Test the base URL, all three Paper Birds URLs, navigation, CSS, and every image
   anonymously over HTTPS, including direct navigation to support and privacy.
9. Add a canonical URL and `og:url` to each HTML head using that verified base.
   For Paper Birds pages, add an absolute `og:image` URL using the verified base
   plus `paperbirds/images/forest.jpg`, with an accurate image description. For
   WoodenDev, use its own appropriate brand image or omit `og:image`.
10. Replace this status table with the actual URLs and completed verification date.

Canonical URLs, `og:url`, and absolute Open Graph images are deliberately omitted
until the production base is confirmed. Titles, descriptions, Open Graph titles and
descriptions, viewport metadata, language, and favicons are already present.

## Flight videos and assets

Seven actual renderer captures replace the screenshot gallery, including the
previously missing free Classic scene. Each video is a silent, 3-second H.264 MP4,
1280×720, 30 fps (90 frames), optimized for progressive playback. Matching JPEG
posters display before playback or when reduced motion is enabled. MP4 preserves
more color detail than GIF with smaller files for these scenes. Looping restarts
at the beginning; these are natural flight excerpts, not seamless animation loops.

The source is the real, unchanged Paper Birds renderer at commit
`fdcfa7ac340ed56018ab6f231e9744ab1935c1e7`. No generated scenery, compositing,
color grading, or application-source modification was used. Seed: `819274`.
A contact sheet of 22 actual frames was inspected to select the Forest and City 2
views. Configuration and start times:

| File stem | Scene | Camera | Season | Start time | Access |
| --- | --- | --- | --- | --- | --- |
| `classic` | Classic plains | Cinematic | Summer | 24 s | Free |
| `forest` | Forest with moon reflected in lake | Chase | Summer | 12 s | Expanded Flight |
| `city2-chase` | City 2 skyline with moon | Chase | Summer | 40 s | Expanded Flight |
| `city2-overhead` | City 2 street grid and rooftops | Overhead | Summer | 40 s | Expanded Flight |
| `city` | City building canyons | Chase | Summer | 24 s | Expanded Flight |
| `village` | Village 2 | Cinematic | Summer | 24 s | Expanded Flight |
| `winter` | Forest | Chase | Winter | 24 s | Expanded Flight |

Expanded captures use three birds, triangle formation, mixed colors, and trails.
Classic uses two monochrome birds, loose formation, no trails, and the free
cinematic camera. Forest density is 0.85 in expanded scenes and the free default of 1 in Classic.
These are development renderer captures, not a claim that final storefront
screenshots or the release archive have been approved. Verify them against the
shipping version before submission. The icon is copied from
`App/Assets.xcassets/AppIcon.appiconset/icon_256x256@1x.png`; its original is unchanged.

`js/previews.js` plays muted videos only while they are visible, pauses when the
page is hidden, honors the system reduced-motion preference, and provides a global
Play/Pause previews button. Native controls remain usable with JavaScript disabled
or autoplay blocked. No external player or tracking library is used.

### Regenerating videos

This is optional offline asset maintenance on macOS with Xcode and Metal, not a
website build requirement. The exporter reads app sources without editing them:

```sh
bash tools/export-previews.sh /Users/woodenh/Documents/Development/private/PaperBirdsScreenSaver
```

It compiles the current app renderer into a temporary bundle, writes intermediate
frames into a new temporary directory, and copies only MP4s and JPEG posters into
this website. No ffmpeg or package manager is required. Inspect each video and
poster after regenerating; future renderer changes may alter the composition.
For manual replacement, retain filenames or update HTML source/poster paths,
scene captions, access labels, and dimensions together.

## Support and release information

Support and privacy contact: **woodendev@gmail.com**, provided by the owner.
Both pages use working `mailto:` links; no fake contact placeholders remain.
The privacy contact section explains that email inquiries disclose the sender's
email address and the information they choose to send so a response can be provided.

Add the verified App Store link on the marketing page when the listing is available.
Replace the planned-release message with “Free download” only after checking live
storefront availability and base price. Do not hard-code the Expanded Flight price.
Confirm the copyright owner and 2026 year in all four footers.

## Verified product and privacy claims

Reviewed on 23 September 2026 against Paper Birds commit
`fdcfa7ac340ed56018ab6f231e9744ab1935c1e7` and the current working copy.
The app repository contained an unrelated untracked `paperbirds_chat.md`, which
was not used as product evidence or modified. No app build or purchase test was run
for this website task. Existing source and release records are distinguished below.

| Claim | Evidence in the Paper Birds repository |
| --- | --- |
| Menu bar, Start Flight, all connected displays, mouse/Escape exit | `App/AppDelegate.swift`, `App/FlightWindow.swift`; current implementation overrides stale single-display wording in settings |
| Idle intervals 1/5/10/20/30 minutes, Never option, login launch | `App/SettingsView.swift`, `Sources/PaperBirdsAppSupport/AppPreferences.swift` |
| Idle suppression while settings visible or display held awake | `App/AppDelegate.swift`, `Sources/PaperBirdsAppSupport/DisplaySleepActivity.swift` |
| Independent app, no installed `.saver`, no security lock replacement | `docs/APP_STORE_ARCHITECTURE.md`, app host implementation, `HANDOFF.md` |
| Free Classic/Summer, 1–2 monochrome birds, loose formation, cinematic camera, no trails | `Sources/FlightCore/FeatureEntitlements.swift` capability resolution |
| Expanded worlds, 1–7 birds, formations, colors, seasons, cameras, density, trails | `FeatureEntitlements.swift`, `App/SettingsView.swift`, world and season implementations |
| One-time optional purchase; no subscription | `Sources/PaperBirdsPurchases/StoreKitStorefront.swift` explicitly requires `.nonConsumable`; purchase UI |
| Restore Purchases procedure | `App/SettingsView.swift`, `ExpandedFlightPurchaseView.swift`, `ExpandedFlightStore.swift`; explicit `AppStore.sync()` |
| macOS 13 minimum | `Package.swift`, `PaperBirds.xcodeproj/project.pbxproj` |
| Apple Silicon and Intel build support | `Tools/AppStore/build.sh`: `ARCHS='arm64 x86_64'`; recorded universal-build checks in `HANDOFF.md` |
| No app analytics, tracking, ads, third-party crash SDK or account system | `docs/PRIVACY.md`, `App/PrivacyInfo.xcprivacy`, app/shared renderer/purchase source, dependency declarations |
| Local preferences and elapsed-idle-time checks | `AppPreferences.swift`, `AppDelegate.swift`; preferences, scene seed/display and uptime usage remain local |
| Apple handles purchases; verified entitlements used locally | `StoreKitStorefront.swift`, `ExpandedFlightStore.swift`; no developer backend in inspected code |
| No external package dependencies | `Package.swift`; Xcode project references local package targets and Apple system frameworks |

The manifest declares no tracking and no collected data types, with UserDefaults
reason CA92.1 and SystemBootTime reason 35F9.1. Public prose describes preferences
and activity checks in ordinary language rather than exposing manifest codes.
The source scan alone is not a review of an eventual shipping archive.

### Unverified release facts

- Actual App Store listing, public availability, base price, registered IAP and
  production purchase behavior cannot be verified from this repository.
- Release documents specify a free app; the website says **planned** free download.
- Native StoreKit sandbox/TestFlight purchase validation remains pending in release
  records. Website support describes implemented UI, not a new successful payment test.
- Intel execution, all physical display combinations, and final archive composition
  were not validated in this task. Universal architecture support is evidenced by
  build configuration and existing release records.
- The final shipping binary and included SDKs must be checked against this privacy
  policy. Current source supports the claims; future build changes may invalidate them.
- The contact email is owner-confirmed; copyright ownership remains to be confirmed.

## Updating privacy

Recheck `docs/PRIVACY.md`, `App/PrivacyInfo.xcprivacy`, source networking/storage,
package dependencies, bundled SDKs, and StoreKit handling against the exact shipping
archive. Update `paperbirds/privacy/index.html` when practices change and revise its
effective date. The contact section describes information received through email support. Do not broaden “no app data collected” to cover Apple or the host.
GitHub Pages logs visitors' IP addresses for security; the website section states
this separately. See [GitHub Pages data collection](https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages#data-collection).

## Adding another product

Create `<product>/index.html`, `<product>/support/index.html`,
`<product>/privacy/index.html`, and `<product>/images/`. Reuse `css/style.css` and
root branding assets. Copy the relative navigation pattern at the corresponding
directory depth. Add a product card inside `#products` on the WoodenDev root page.
Write a distinct support page and privacy policy for that product, verify its own
claims, and add canonical metadata only using the confirmed deployment base.

## Before App Store Submission

- [ ] Actual GitHub Pages URL verified
- [ ] Marketing URL works publicly
- [ ] Support URL works publicly
- [ ] Privacy Policy URL works publicly
- [x] Placeholder support email replaced with woodendev@gmail.com
- [x] Actual 3-second renderer videos and matching posters added, including Classic and City 2
- [ ] Media approved against the final shipping build
- [x] Expanded Flight content accurately identified against current source
- [ ] Privacy Policy verified against shipping build
- [ ] All internal links tested on public deployment (local checks completed)
- [ ] Copyright owner/year verified
- [ ] No TODO placeholders remain on public pages
- [ ] App Store availability and free base price verified; real download link added
- [ ] Canonical URLs and appropriate absolute Open Graph image added

Marketing URL: **NOT READY**. Support URL: **NOT READY**.
Privacy Policy URL: **NOT READY**. The site is a locally reviewable implementation,
not a claim of deployment or App Store submission readiness.

## Local validation completed

- All four pages opened in the browser at widths 1280, 375, and 320 pixels.
  No horizontal overflow; one H1 per page; visible images loaded.
- A static HTML check resolved all 72 internal links, asset references, and anchors;
  every image includes alternative text and intrinsic dimensions. This describes the initial static site; video-update checks are recorded below.
- Product and privacy layouts inspected visually; desktop and mobile CSS checked.
- No public HTTPS/deployment checks are claimed. Public verification remains blocked
  by disabled Pages and missing repository write/admin access.

### Video update validation — 23 September 2026

- All seven MP4 files verified with AVFoundation: 3.0 seconds, 1280×720,
  approximately 30 fps, one video track, no audio track; complete sample reads.
- All seven scenes decoded in the local browser with no media errors.
- Verified visible playback, offscreen pausing, and the global pause/resume control.
- Desktop (1280px) and mobile (375px) layouts inspected; no horizontal overflow.
- All 92 local links, source references, posters, and anchors resolve.
- Both contact pages link to `mailto:woodendev@gmail.com`; fake email removed.
- Export shell syntax and `git diff --check` pass.
- Reduced-motion handling is implemented; no system preference was changed during QA.
- App repository remains unchanged; its pre-existing untracked note is untouched.
