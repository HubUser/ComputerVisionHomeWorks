#!/usr/bin/env bash

set -Eeuo pipefail
# Propagate errexit into subshells where supported (Bash ≥4.4)
shopt -s inherit_errexit 2>/dev/null || true

log() { printf '%s [INFO] %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$*"; }
log_err() { printf '%s [ERROR] %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$*" >&2; }
trap 'rc=$?; log_err "Command failed (exit $rc) at ${BASH_SOURCE[0]}:${LINENO}: ${BASH_COMMAND}"; exit $rc' ERR

log "Creating virtual environment at ./cv"
python -m venv cv

log "Activating virtual environment"
# shellcheck source=/dev/null
source ./cv/bin/activate

log "Installing dependencies from requirements.txt"
pip install -r requirements.txt
log "Dependencies installed successfully"

log "Launching Jupyter Notebook"
exec jupyter notebook
