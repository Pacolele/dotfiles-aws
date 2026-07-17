# Dotfiles

Personal development environment configuration for macOS and Linux.

## What's included

- **Neovim** — LazyVim-based config with catppuccin theme, LSP (Java, Python, Lua, HTML/CSS/JS, Django), blink.cmp, snacks explorer/picker, dropbar breadcrumbs
- **Zsh + Prezto** — with autosuggestions, syntax highlighting, history-substring-search, sorin prompt theme
- **Tmux** — vim-style navigation, fzf session/window switcher, TPM with resurrect + continuum
- **Alacritty** — catppuccin macchiato theme, FiraCode Nerd Font

## Dependencies

| Tool | Purpose |
|------|---------|
| neovim | Editor |
| tmux | Terminal multiplexer |
| alacritty | Terminal emulator |
| fzf | Fuzzy finder |
| eza | Modern ls replacement |
| zoxide | Smart cd |
| fd | Fast file finder (used by nvim picker) |
| ripgrep | Fast grep (used by nvim grep) |
| git | Version control + prezto/tpm install |
| FiraCode Nerd Font | Terminal font with icons |

## Installation

### Quick install

```bash
git clone git@github.com:Pacolele/dotfiles-aws.git ~/dotfiles-aws
cd ~/dotfiles-aws
./install.sh
```

The install script will:
1. Install dependencies (via Homebrew on macOS, pixi on Linux)
2. Install Prezto (zsh framework)
3. Install TPM (tmux plugin manager)
4. Back up any existing configs to `~/.dotfiles-backup/<timestamp>/`
5. Symlink all configs to the correct locations

### macOS (Homebrew)

If you prefer manual install:

```bash
brew install neovim tmux alacritty fzf eza zoxide fd ripgrep git
brew install --cask font-fira-code-nerd-font
```

### Linux

Using [pixi](https://pixi.sh) (works on any distro):

```bash
curl -fsSL https://pixi.sh/install.sh | bash
pixi global install neovim tmux fzf eza zoxide fd-find git
# Install alacritty and ripgrep via your package manager
```

### Font

Install FiraCode Nerd Font:
- **macOS**: `brew install --cask font-fira-code-nerd-font`
- **Linux**: Download from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) or use your package manager

## Post-install

1. **Restart your terminal** (or `source ~/.zshrc`)
2. **Tmux plugins**: Open tmux, press `Ctrl+a, I` to install plugins
3. **Neovim plugins**: Open nvim, plugins install automatically on first launch

## Key bindings

### Tmux (prefix = Ctrl+a)

| Key | Action |
|-----|--------|
| `prefix + s` | Window switcher (fzf) |
| `prefix + S` | Session switcher (fzf) |
| `prefix + x` | Kill pane |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + 1-9` | Switch to window |
| `prefix + c` | New window |
| `prefix + r` | Reload config |

### Neovim (leader = Space)

| Key | Action |
|-----|--------|
| `Space + ff` | Find files |
| `Space + sg` | Grep search |
| `Space + e` | File explorer (cwd) |
| `Space + o` | Quick outline (symbols) |
| `Space + cs` | Sidebar outline |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `Space + ca` | Code action |
| `Space + cr` | Rename symbol |
| `[[` / `]]` | Jump backward/forward |
| `gsa` | Add surrounding |
| `gsd` | Delete surrounding |
| `gsr` | Replace surrounding |

### Shell aliases

| Alias | Command |
|-------|---------|
| `ls` | `eza -a --group-directories-first --icons` |
| `ll` | `eza -al --group-directories-first --icons` |
| `ld` | `eza -D --icons` (directories only) |
| `lt` | `eza -a --sort=modified --icons` |
| `src` | `source ~/.zshrc` |
| `zconf` | `nvim ~/.zshrc` |

## File structure

```
dotfiles-aws/
├── nvim/              → ~/.config/nvim
│   ├── init.lua
│   ├── lua/config/    (options, keymaps, autocmds)
│   └── lua/plugins/   (LSP, theme, tools)
├── zsh/
│   ├── .zshrc         → ~/.zshrc
│   ├── .zpreztorc     → ~/.zpreztorc
│   └── .zprofile      → ~/.zprofile
├── tmux/
│   └── .tmux.conf     → ~/.tmux.conf
├── alacritty/         → ~/.config/alacritty
│   ├── alacritty.toml
│   └── themes/catppuccin-macchiato.toml
├── install.sh
└── README.md
```

## Backup & restore

Existing configs are backed up to `~/.dotfiles-backup/<timestamp>/` before being replaced. To restore:

```bash
# List backups
ls ~/.dotfiles-backup/

# Restore a specific backup
cp -r ~/.dotfiles-backup/<timestamp>/.zshrc ~/
cp -r ~/.dotfiles-backup/<timestamp>/nvim ~/.config/
# etc.
```

## Updating

After pulling new changes:

```bash
cd ~/dotfiles-aws
git pull
```

Since configs are symlinked, changes take effect immediately (restart nvim/tmux if needed).
