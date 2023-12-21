#!/bin/bash

set -euxo pipefail

UCM_RELEASE="${UCM_RELEASE:-latest}"

TRANSCRIPT=pull-and-run-tests.md

envsubst < pull-and-run-tests.tpl.md > $TRANSCRIPT

curl -L "https://github.com/unisonweb/unison/releases/download/${UCM_RELEASE}/ucm-linux.tar.gz" | tar -xz

exit_status=0

./ucm transcript "$TRANSCRIPT" || exit_status=$?
cat pull-and-run-tests.output.md

exit "$exit_status"
