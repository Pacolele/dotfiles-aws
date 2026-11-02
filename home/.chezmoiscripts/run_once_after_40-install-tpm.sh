#!/usr/bin/env bash
# Clone TPM (tmux plugin manager) if it is missing. Plugins: prefix + I inside tmux.
set -euo pipefail

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
