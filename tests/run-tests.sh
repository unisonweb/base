#!/usr/bin/env bash

set -euxo pipefail

TRANSCRIPT=pull-and-run-tests.md

envsubst < pull-and-run-tests.tpl.md > $TRANSCRIPT

exit_status=0

ucm transcript "$TRANSCRIPT" || exit_status=$?
cat pull-and-run-tests.output.md

exit "$exit_status"
