#!/usr/bin/env bash

set -euxo pipefail

TRANSCRIPT=pull-and-run-tests.md

envsubst < pull-and-run-tests.tpl.md > $TRANSCRIPT

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

curl --fail-with-body -L "https://github.com/unisonweb/unison/releases/download/${UCM_RELEASE}/$(release_file_name)" | tar -xz

exit_status=0

./ucm transcript "$TRANSCRIPT" || exit_status=$?
cat pull-and-run-tests.output.md

exit "$exit_status"
