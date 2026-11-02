#!/usr/bin/env bash
# Bootstrap: install chezmoi, back up existing configs, apply this repo.
# Safe to re-run. Day-to-day use is plain `chezmoi` (see README).
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
export PATH="$HOME/.local/bin:$HOME/.pixi/bin:$PATH"

echo "Dotfiles installer (chezmoi)"
echo "Repo:   $DOTFILES_DIR"
echo "Backup: $BACKUP_DIR"
echo ""

# --- chezmoi ---
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "Installing chezmoi to ~/.local/bin..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi

# --- Remove symlinks left by the old symlink-based installer ---
for p in .config/nvim .config/alacritty .zshrc .zpreztorc .zprofile .tmux.conf; do
  target="$HOME/$p"
  if [[ -L "$target" && "$(readlink "$target")" == "$DOTFILES_DIR"/* ]]; then
    echo "  Removing old symlink: $target"
    rm "$target"
  fi
done

# --- Generate ~/.config/chezmoi/chezmoi.toml (prompts once) ---
# Extra args go to chezmoi init, e.g. ./install.sh --promptBool "work machine=false"
chezmoi init --source "$DOTFILES_DIR" "$@"

# --- Back up existing files chezmoi is about to modify ---
backed_up=0
while IFS= read -r line; do
  rel="${line:3}"
  target="$HOME/$rel"
  if [[ -f "$target" && ! -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp -p "$target" "$BACKUP_DIR/$rel"
    backed_up=$((backed_up + 1))
  fi
done < <(chezmoi status --include files --path-style relative)
(( backed_up > 0 )) && echo "Backed up $backed_up file(s) to $BACKUP_DIR"

# --- Apply (also runs pixi / prezto / tpm bootstrap scripts) ---
chezmoi apply --verbose

echo ""
echo "Done. Restart your terminal or run: exec zsh"
echo "Tmux plugins: open tmux and press prefix + I"
