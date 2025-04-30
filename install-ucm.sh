#!/usr/bin/env bash

set -euxo pipefail

release_file_name='ucm-linux-x64.tar.gz'

release_url() {
  case "$UCM_RELEASE" in
    'latest')
      echo "https://github.com/unisonweb/unison/releases/latest/download/${release_file_name}"
      ;;
    *)
      escaped_release=${UCM_RELEASE//\//%2F}
      echo "https://github.com/unisonweb/unison/releases/download/${escaped_release}/${release_file_name}"
      ;;
  esac
}

mkdir -p /opt/unisonlanguage

curl --fail-with-body -L "$(release_url)" | tar -xz -C /opt/unisonlanguage

ln -s /opt/unisonlanguage/ucm /usr/local/bin/ucm
