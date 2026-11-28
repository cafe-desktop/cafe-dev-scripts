#!/bin/bash

# Installs the build helper scripts into the current directory.
#
# Designed so that a transient GitHub error page (502/503/504) can never
# break the build:
#
#   1. Preferred path (no network at all): if a local checkout of
#      cafe-dev-scripts is available -- either pointed at by the
#      DEV_SCRIPTS_SRC environment variable, or because this script is
#      being run from inside such a checkout -- the files are copied
#      from there.
#
#   2. Fallback path (standalone download): files are fetched with
#      --fail/--retry and their content is validated before use, so a
#      corrupted download fails the build with a clear error instead of
#      executing an HTML page.

set -e
set -v
set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOCAL_SRC="${DEV_SCRIPTS_SRC:-}"
if [ -z "$LOCAL_SRC" ] && [ -d "$SCRIPT_DIR/../../travis/build" ]; then
  LOCAL_SRC="$(cd "$SCRIPT_DIR/../.." && pwd)"
fi

BASE_URL="https://raw.githubusercontent.com/cafe-desktop/cafe-dev-scripts/master/travis"

fetch() {
  # fetch <relative path inside travis/> <output file>
  local rel="$1" out="$2"
  if [ -n "$LOCAL_SRC" ] && [ -f "$LOCAL_SRC/travis/$rel" ]; then
    cp "$LOCAL_SRC/travis/$rel" "$out"
    return 0
  fi
  # -f: fail (with non-zero exit) on HTTP errors instead of saving the
  #     error page.  --retry: curl already retries transient errors such
  #     as timeouts and HTTP 408/429/500/502/503/504; --retry-all-errors
  #     extends that to everything else.
  curl -fsSL --retry 10 --retry-delay 5 --retry-max-time 180 \
       --retry-all-errors --connect-timeout 20 \
       -o "$out" "$BASE_URL/$rel"
  # Sanity check: every helper script starts with a shebang.
  if [ "$(head -c 2 "$out")" != "#!" ]; then
    echo "ERROR: $out does not start with '#!' (download got an HTML error page?)" >&2
    exit 1
  fi
}

fetch docker-build docker-build
fetch gen-index.sh gen-index
fetch build/html-cppcheck.sh html-cppcheck
fetch build/install-from-git.sh install-from-git
fetch build/install-from-debs.sh install-from-debs
fetch build/make-scanbuild.sh make-scanbuild
fetch build/after-build.sh after-build
fetch build/before-build.sh before-build
fetch build/debrepo-install.sh debrepo-install
fetch build/build-debs.sh build-debs
fetch build/exit-warning.sh exit-warning
fetch build/testrepo.sh testrepo

chmod +x docker-build gen-index html-cppcheck install-from-git install-from-debs make-scanbuild after-build before-build debrepo-install build-debs exit-warning testrepo
