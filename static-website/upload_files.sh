#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <s3-bucket-name> [zip-file]"
  echo "Example: $0 static-website-20260410 udacity-starter-website.zip"
  exit 1
}

bucket="${1:-}"
zip_file="${2:-udacity-starter-website.zip}"

if [[ -z "$bucket" ]]; then
  usage
fi

if [[ ! -f "$zip_file" ]]; then
  echo "Error: zip file not found: $zip_file" >&2
  exit 1
fi

tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

unzip -q "$zip_file" -d "$tmp_dir"

aws s3 sync "$tmp_dir" "s3://$bucket" --delete

echo "Uploaded files from $zip_file to s3://$bucket"
