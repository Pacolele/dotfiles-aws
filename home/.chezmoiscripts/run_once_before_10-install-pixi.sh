#!/usr/bin/env bash
# Install pixi (user-level package manager) if it is missing.
set -euo pipefail

if command -v pixi >/dev/null 2>&1 || [[ -x "$HOME/.pixi/bin/pixi" ]]; then
  exit 0
fi

echo "Installing pixi..."
# ~/.zprofile already puts ~/.pixi/bin on PATH, so skip the installer's rc edits.
curl -fsSL https://pixi.sh/install.sh | PIXI_NO_PATH_UPDATE=1 bash
