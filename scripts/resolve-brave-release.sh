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

release_has_asset() {
	local release_id=$1 page=1 page_count assets_json asset_url

	while :; do
		assets_json=$(api_get "/repos/${repo}/releases/${release_id}/assets?per_page=100&page=${page}")
		page_count=$(jq -e 'length' <<<"$assets_json")
		asset_url=$(jq -e -r --arg asset "$asset" '
			.[]
			| select(.name == $asset and (.state // "uploaded") == "uploaded")
			| .browser_download_url
		' <<<"$assets_json" | head -1) || true

		if [ -n "$asset_url" ]; then
			return 0
		fi
		if [ "$page_count" -lt 100 ]; then
			return 1
		fi
		page=$((page + 1))
	done
}

page=1
found_channel_release=false
while :; do
	page_json=$(api_get "/repos/${repo}/releases?per_page=100&page=${page}")
	page_count=$(jq -e 'length' <<<"$page_json")

	mapfile -t releases < <(jq -c --arg prefix "$release_prefix" '
		.[] | select((.name // "") | startswith($prefix + " v"))
	' <<<"$page_json")

	for release_json in "${releases[@]}"; do
		found_channel_release=true
		release_id=$(jq -e -r '.id' <<<"$release_json")
		tag=$(jq -e -r '.tag_name // empty' <<<"$release_json")
		version=${tag#v}

		if ! [[ $version =~ ^[0-9]+([.][0-9]+)+$ ]]; then
			echo >&2 "Skipping Brave ${release_prefix} release with unexpected tag: ${tag:-<empty>}"
			continue
		fi

		if release_has_asset "$release_id"; then
			echo >&2 "Resolved Brave ${release_prefix}: ${version} (${asset})"
			printf '%s\n' "$version"
			exit 0
		fi

		echo >&2 "Brave ${release_prefix} ${tag} is not ready: asset '${asset}' is missing; falling back to the previous ${release_prefix} release"
	done

	if [ "$page_count" -lt 100 ]; then
		break
	fi
	page=$((page + 1))
done

if [ "$found_channel_release" = false ]; then
	echo >&2 "Could not find any Brave ${release_prefix} release in ${repo}"
else
	echo >&2 "Could not find any Brave ${release_prefix} release with uploaded asset '${asset}'"
fi
exit 2
