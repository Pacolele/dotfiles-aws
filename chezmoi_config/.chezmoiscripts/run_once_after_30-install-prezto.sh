#!/usr/bin/env bash
# Clone Prezto (includes powerlevel10k as a submodule) if it is missing.
set -euo pipefail

if [[ ! -d "$HOME/.zprezto" ]]; then
  echo "Installing Prezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi
