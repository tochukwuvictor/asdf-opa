#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/open-policy-agent/opa"

fail() {
  echo -e "asdf-opa: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

get_arch () {
  uname | tr '[:upper:]' '[:lower:]'
}

download_release() {
  local version filename platform url
  version="$1"
  filename="$2"
  platform="$(get_arch)"

  url="$GH_REPO/releases/download/v${version}/opa_${platform}_amd64"

  echo "* Downloading opa release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-opa supports release installs only"
  fi

  local binary_path="$install_path/bin/opa"
  (
    mkdir -p "$install_path/bin"
    download_release "$version" "$binary_path"
    chmod +x "$binary_path"

    local tool_cmd
    tool_cmd="opa"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "opa $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing opa $version."
  )
}
