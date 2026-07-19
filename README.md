# Or1g1n Brave

Automated build for a patched, arm64-v8a Brave APK. Build uses Morphe CLI and two patch bundles:

- `bufferk/morphe-patches`
- `MorpheApp/morphe-patches`

Output package name: `vip.dh6k.brave.or1g1n`.

Patched APK installs beside official Brave. It does not replace `com.brave.browser`.

## Download

Download newest APK from [Releases](../../releases/latest).

Current build target:

- Brave, arm64-v8a
- version selected automatically from patch compatibility
- included patch: `Brave Origin`
- additional patch: `Change package name`

## Install

1. Download `brave-revanced-*-arm64-v8a.apk` from latest release.
2. Enable installation from your file manager or browser when Android asks.
3. Install APK.
4. Open **Or1g1n Brave**.

Official Brave may stay installed. Data, extensions, and settings do not transfer automatically because package name differs.

## Updates

GitHub Actions builds releases automatically. Install newer APK over existing `vip.dh6k.brave.or1g1n` app to update.

Check [release notes](../../releases) for built Brave version, patch-bundle versions, and APK files.

## Build locally

Requirements:

- Linux or Termux
- Java 21
- `bash`, `curl`, `unzip`, and common GNU utilities

Clone repository, then run:

```bash
./build.sh config.toml
```

Built APK appears in `build/`.

Termux helper:

```bash
bash <(curl -sSf https://raw.githubusercontent.com/dh6k/or1g1n/main/build-termux.sh)
```

## Configuration

[`config.toml`](./config.toml) controls source APK, package identity, patch bundles, included patches, and build mode. Option reference: [`CONFIG.md`](./CONFIG.md).

## License

Project uses [GPL-3.0](./LICENSE). Brave, Morphe, and their related marks belong to their respective owners.
