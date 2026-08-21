#!/usr/bin/env bash

set -euo pipefail

channel=${1:?usage: resolve-brave-release.sh <release-android|beta-android|nightly-android> [asset]}
asset=${2:-BraveMonoarm64.apk}
repo=${BRAVE_REPO:-brave/brave-browser}

case "$channel" in
	release-android) release_prefix=Release ;;
	beta-android) release_prefix=Beta ;;
	nightly-android) release_prefix=Nightly ;;
	*)
		echo >&2 "Unsupported Brave channel: $channel"
		exit 64
		;;
esac

api_get() {
	local endpoint=$1
	gh api -H "Accept: application/vnd.github+json" "$endpoint"
}

release_json=""
page=1
while :; do
	page_json=$(api_get "/repos/${repo}/releases?per_page=100&page=${page}")
	page_count=$(jq -e 'length' <<<"$page_json")

	release_json=$(jq -e -c --arg prefix "$release_prefix" '
		[.[] | select((.name // "") | startswith($prefix + " v"))] | .[0] // empty
	' <<<"$page_json") || true

	if [ -n "$release_json" ]; then
		break
	fi
	if [ "$page_count" -lt 100 ]; then
		echo >&2 "Could not find latest Brave ${release_prefix} release in ${repo}"
		exit 1
	fi
	page=$((page + 1))
done

release_id=$(jq -e -r '.id' <<<"$release_json")
tag=$(jq -e -r '.tag_name // empty' <<<"$release_json")
version=${tag#v}
if ! [[ $version =~ ^[0-9]+([.][0-9]+)+$ ]]; then
	echo >&2 "Unexpected Brave ${release_prefix} tag: ${tag:-<empty>}"
	exit 1
fi

asset_url=""
page=1
while :; do
	assets_json=$(api_get "/repos/${repo}/releases/${release_id}/assets?per_page=100&page=${page}")
	page_count=$(jq -e 'length' <<<"$assets_json")
	asset_url=$(jq -e -r --arg asset "$asset" '
		.[] | select(.name == $asset and (.state // "uploaded") == "uploaded") | .browser_download_url
	' <<<"$assets_json" | head -1) || true

	if [ -n "$asset_url" ]; then
		break
	fi
	if [ "$page_count" -lt 100 ]; then
		echo >&2 "Latest Brave ${release_prefix} release ${tag} exists, but asset '${asset}' is not uploaded yet"
		exit 2
	fi
	page=$((page + 1))
done

echo >&2 "Resolved Brave ${release_prefix}: ${version} (${asset})"
printf '%s\n' "$version"
