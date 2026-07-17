#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

echo "Dotfiles installer"
echo "=================="
echo "Repo:   $DOTFILES_DIR"
echo "Backup: $BACKUP_DIR"
echo ""

# --- Install dependencies ---
install_deps() {
  echo "Installing dependencies..."
  if [[ "$OSTYPE" == darwin* ]]; then
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install neovim tmux alacritty fzf eza zoxide fd git
  else
    # Linux - use pixi for cross-distro support
    if ! command -v pixi &>/dev/null; then
      echo "Installing pixi..."
      curl -fsSL https://pixi.sh/install.sh | bash
      export PATH="$HOME/.pixi/bin:$PATH"
    fi
    pixi global install neovim tmux fzf eza zoxide fd-find git
    echo "Note: Install alacritty via your package manager (apt/dnf/pacman)"
  fi
}

# --- Backup existing configs ---
backup() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    echo "  Backing up: $target -> $BACKUP_DIR/"
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
  fi
}

# --- Symlink helper ---
link_file() {
  local src="$1"
  local dest="$2"
  backup "$dest"
  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  echo "  Linked: $dest -> $src"
}

# --- Install Prezto ---
install_prezto() {
  if [[ ! -d "$HOME/.zprezto" ]]; then
    echo "Installing Prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
  else
    echo "Prezto already installed."
  fi
}

# --- Install TPM (Tmux Plugin Manager) ---
install_tpm() {
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    echo "TPM already installed."
  fi
}

# --- Main ---
echo "[1/6] Installing dependencies..."
install_deps

echo ""
echo "[2/6] Installing Prezto..."
install_prezto

echo ""
echo "[3/6] Installing TPM..."
install_tpm

echo ""
echo "[4/6] Linking Neovim config..."
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo ""
echo "[5/6] Linking shell configs..."
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.zpreztorc" "$HOME/.zpreztorc"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo ""
echo "[6/6] Linking Alacritty config..."
link_file "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

echo ""
echo "Done! Restart your terminal or run: source ~/.zshrc"
echo "For tmux plugins, open tmux and press: prefix + I"
