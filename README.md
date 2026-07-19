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

## Troubleshooting

### Passkeys

> [!WARNING]
> Or1g1n Brave has a different signing identity from official Brave. Password managers can therefore mark it as an unrecognized app and reject passkey creation or sign-in. See [morphe-patches issue #18](https://github.com/bufferk/morphe-patches/issues/18).

Current builds apply Morphe's `Change package name` patch with both `Update Permissions` and `Update Providers` enabled. Install latest release before retrying passkeys.

For Bitwarden, start passkey sign-in from Or1g1n Brave. When Bitwarden asks to trust the unrecognized app, verify it was opened by the APK from this repository's release, then approve it. Retry passkey sign-in after approval.

Passkeys belong to the website or app where they were created. They are not transferred with Brave browser data. A passkey saved in Google Password Manager or another enabled password manager can still be offered for the same website in Or1g1n Brave.

If passkey sign-in does not appear or fails:

1. Confirm the site supports passkeys and use its **Use a passkey** sign-in option.
2. In Android **Settings**, open **Passwords, passkeys & accounts**. Enable your password manager as a passkey provider.
3. Update Google Play services and your password-manager app, then restart Or1g1n Brave.
4. Verify the passkey exists in your password manager and use the same account that created it.
5. Sign in with a recovery method, then create a new passkey if the site reports that the existing one is invalid.

Do not uninstall official Brave until passkey sign-in works in Or1g1n Brave. It may remain needed for existing browser data or recovery access.

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
