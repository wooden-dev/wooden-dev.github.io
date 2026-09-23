# WoodenDev website

A lightweight, multi-product website for WoodenDev, with a dedicated Paper Birds
marketing page, support page, and privacy policy. Plain HTML and shared CSS;
no JavaScript, build step, package manager, cookies, analytics, or external fonts.
The Paper Birds application repository was inspected read-only and not modified.

## Directory structure

```text
.
├── .nojekyll
├── README.md
├── index.html
├── css/
│   └── style.css
├── images/
│   └── favicon.svg
└── paperbirds/
    ├── index.html
    ├── support/
    │   └── index.html
    ├── privacy/
    │   └── index.html
    └── images/
        ├── app-icon.png
        ├── hero.jpg
        ├── forest.jpg
        ├── winter.jpg
        ├── city.jpg
        └── village.jpg
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
   plus `paperbirds/images/hero.jpg`, with an accurate image description. For
   WoodenDev, use its own appropriate brand image or omit `og:image`.
10. Replace this status table with the actual URLs and completed verification date.

Canonical URLs, `og:url`, and absolute Open Graph images are deliberately omitted
until the production base is confirmed. Titles, descriptions, Open Graph titles and
descriptions, viewport metadata, language, and favicons are already present.

## Screenshots and assets

No fabricated application screenshots or generated replacement scenery are used.
The app icon is a copy of `App/Assets.xcassets/AppIcon.appiconset/icon_256x256@1x.png`
in Paper Birds. The original asset was not changed.

The five 960×404 JPEGs are real stills exported from the app's bundled
`App/Media/ExpandedFlightPreview.mp4`, not screenshots of the final shipping app.
The exporter's scene list in `Tools/AppStore/PreviewMovie.swift` establishes provenance:

| Website image | Video time | Actual scene | Access |
| --- | --- | --- | --- |
| `hero.jpg` | 1 second | Forest, spring, triangle formation | Expanded Flight |
| `forest.jpg` | 3 seconds | Forest, autumn, loose formation | Expanded Flight |
| `winter.jpg` | 5 seconds | Forest, winter, V formation | Expanded Flight |
| `city.jpg` | 7 seconds | City, summer, triangle formation | Expanded Flight |
| `village.jpg` | 11 seconds | Village 2, summer, loose formation | Expanded Flight |

The pages explicitly call these preview stills and label the paid content.
The original video and large development assets were not copied.
Other inspected assets include the app's icon set, legacy saver thumbnails, and
Expanded Flight promotional/review PNGs. Legacy saver thumbnails are not used as
screenshots of the standalone app.

Before release:

- Supply a genuine Classic plains screenshot from the free shipping app. Save as
  `paperbirds/images/classic.jpg` and replace the labeled placeholder in the gallery
  with an `<img>` and accurate `alt`, `width`, and `height` attributes.
- Replace preview stills with final approved screenshots under the same filenames,
  or update both paths and captions if scenes change. Keep paid-only labels.
- Use reasonably compressed JPEGs and preserve aspect ratios. Update intrinsic
  dimensions when replacing images. Do not upscale these preview frames.
- Update hero/gallery copy and alt text to describe the final images; remove
  “preview” and “screenshots to come” wording only when accurate.

## Support and release information

**TODO: REPLACE BEFORE APP STORE SUBMISSION** — add the owner's real, monitored
support email to both `paperbirds/support/index.html` and
`paperbirds/privacy/index.html`. `support@example.com` exists only in TODO source
comments as an explicitly fake placeholder; it is not rendered or linked.
The visible contact section currently states that a public contact is forthcoming.

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
- Real contact address and copyright ownership remain owner-provided release items.

## Updating privacy

Recheck `docs/PRIVACY.md`, `App/PrivacyInfo.xcprivacy`, source networking/storage,
package dependencies, bundled SDKs, and StoreKit handling against the exact shipping
archive. Update `paperbirds/privacy/index.html` when practices change and revise its
effective date. Adding email support may require describing how support messages
are handled. Do not broaden “no app data collected” to cover Apple or the host.
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
- [ ] Placeholder support email replaced
- [ ] Final Paper Birds screenshots added
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
  every image includes alternative text and intrinsic dimensions.
- Product and privacy layouts inspected visually; desktop and mobile CSS checked.
- No public HTTPS/deployment checks are claimed. Public verification remains blocked
  by disabled Pages and missing repository write/admin access.
