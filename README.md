# Or1g1n Brave

English is shown by default. Vietnamese version: [README.vi.md](./README.vi.md).

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

1. Download `brave-or1g1n-*-arm64-v8a.apk` from latest release.
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

#### Important: Autofill and passwords

Use the official Bitwarden Android client for passwords, autofill, and passkeys: [Google Play](https://play.google.com/store/apps/details?id=com.x8bit.bitwarden) or [bitwarden/android](https://github.com/bitwarden/android). Other clients, including [Keyguard](https://github.com/AChep/keyguard-app), cannot use passkeys in this browser.

Set up Bitwarden with [bitwarden.com](https://bitwarden.com) or [bitwarden.eu](https://bitwarden.eu). For advanced use, self-host with [Nodewarden](https://github.com/shuaiplus/nodewarden), following this [Nodewarden self-host guide](https://voz.vn/t/huong-dan-self-host-bitwarden-mien-phi-voi-cloudflare-workers.1253236/).

Self-hosting can avoid repeated email-verification prompts and includes some premium features, which can reduce subscription costs. Back up or migrate every password from other password managers before switching.

Current builds apply Morphe's `Change package name` patch with both `Update Permissions` and `Update Providers` enabled. Install latest release before retrying passkeys.

For Bitwarden, start passkey sign-in from Or1g1n Brave. When Bitwarden asks to trust the unrecognized app, verify it was opened by the APK from this repository's release, then approve it. Retry passkey sign-in after approval.

Passkeys belong to the website or app where they were created. They are not transferred with Brave browser data.

If passkey sign-in does not appear or fails:

1. Confirm the site supports passkeys and use its **Use a passkey** sign-in option.
2. In Android **Settings**, open **Passwords, passkeys & accounts**. Enable Bitwarden as the passkey provider.
3. Update Google Play services and Bitwarden, then restart Or1g1n Brave.
4. Verify the passkey exists in Bitwarden and use the same account that created it.
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

Source code and documentation in this repository are licensed under [GNU GPL v3.0](./LICENSE). You may run, study, modify, and redistribute them. When redistributing modified versions, you must provide corresponding source code and retain GPL-3.0.

Software is provided as-is, without warranty. GPL-3.0 does not grant rights to Brave, Morphe, Bitwarden, third-party patch bundles, or their marks and assets. Their own terms still apply; built APKs may include third-party components under separate terms.
