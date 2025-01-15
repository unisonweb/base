#!/usr/bin/env bash

set -euxo pipefail

release_file_name() {
  case "$UCM_RELEASE" in
    "release%2F0.5.23"  | "release%2F0.5.27")
      echo "ucm-linux.tar.gz"
      ;;
    *)
      echo "ucm-linux-x64.tar.gz"
      ;;
  esac
}

mkdir -p /opt/unisonlanguage

curl --fail-with-body -L "https://github.com/unisonweb/unison/releases/download/${UCM_RELEASE}/$(release_file_name)" | tar -xz -C /opt/unisonlanguage

ln -s /opt/unisonlanguage/ucm /usr/local/bin/ucm
