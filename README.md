# Dotfiles

Linux development environment, managed with [chezmoi](https://www.chezmoi.io).

## What's included

- **Neovim**: LazyVim-based config with catppuccin theme, LSP (Java, Python, Lua, HTML/CSS/JS), blink.cmp, snacks explorer/picker, dropbar breadcrumbs
- **Zsh + Prezto**: autosuggestions, syntax highlighting, history-substring-search, powerlevel10k prompt, fzf tmux session picker on shell start (skip with `NO_TMUX=1`)
- **Tmux**: vim-style navigation, fzf session/window switcher, TPM with resurrect + continuum
- **Pixi**: global tool manifest (`~/.pixi/manifests/pixi-global.toml`), synced with `pixi global sync`
- **Alacritty**: catppuccin macchiato theme, FiraMono Nerd Font
- **ls / eza**: Catppuccin Macchiato folder and file-type colors, loaded from `~/.config/eza/colors.zsh`; interactive Zsh clears inherited `NO_COLOR` to enable coloring
- **Rofi**: [adi1090x/rofi](https://github.com/adi1090x/rofi) themes, fetched by chezmoi at a pinned commit; launcher type-1 / style-6 with catppuccin colours
- **Lazygit**: `~/.config/lazygit/config.yml` (currently empty, lazygit defaults)
- **Scripts**: `~/scripts/git-script/pretty-status` (used by the `gst` alias)

## Tools

Installed by pixi from the managed manifest: neovim, zsh, tmux, fzf, zoxide, eza, fd, ripgrep, chezmoi, maven, OpenJDK 17/21/25, xclip, xdotool, tealdeer.

Install yourself with the distro package manager: `git`, `curl`, `alacritty`, `rofi`, `lazygit`, `fontconfig`, FiraMono Nerd Font ([nerdfonts.com](https://www.nerdfonts.com/font-downloads)).

## Installation

```bash
git clone git@github.com:Pacolele/dotfiles-aws.git ~/dotfiles-aws
cd ~/dotfiles-aws
./install.sh
```

`install.sh`:
1. Installs chezmoi to `~/.local/bin` if it is missing.
2. Removes symlinks left by the old symlink-based installer.
3. Runs `chezmoi init`, which asks whether this is a work machine and stores the answers in `~/.config/chezmoi/chezmoi.toml` (never committed).
4. Backs up every existing file chezmoi will change to `~/.dotfiles-backup/<timestamp>/`.
5. Runs `chezmoi apply`, which writes the configs and runs the bootstrap scripts in `chezmoi_config/.chezmoiscripts/`:
   - install pixi if missing
   - `pixi global sync` (re-runs whenever the manifest changes)
   - clone Prezto (with powerlevel10k) and TPM if missing
   - download the externals in `chezmoi_config/.chezmoiexternal.toml` (rofi themes, rofi fonts) and run `fc-cache`

Without prompts, for example on a personal machine:

```bash
./install.sh --promptBool "work machine=false"
```

### Machine profiles

| Answer | Effect |
|--------|--------|
| `work machine = false` | Generic Linux setup |
| `work machine = true` | Adds the AWS CodeArtifact token refresh (`ca-refresh`), M3/Atlas aliases and `LIBGL_ALWAYS_SOFTWARE=1`. Also prompts for the AWS SSO session, profile and the two CodeArtifact domain-owner account IDs. |

To change answers later, edit `~/.config/chezmoi/chezmoi.toml` and run `chezmoi apply`.

## Post-install

1. Restart the terminal (or `exec zsh`).
2. Tmux plugins: open tmux and press `Ctrl+a, I`.
3. Neovim plugins install on first launch.

## Daily use

The source is this repo (`chezmoi source-path` prints `~/dotfiles-aws/home`). Live files are plain copies, so edits must be synced one way or the other.

| Task | Command |
|------|---------|
| Edit a config through chezmoi | `chezmoi edit ~/.tmux.conf` then `chezmoi apply` |
| Edited the live file directly | `chezmoi re-add` (non-template files) or edit the `.tmpl` source by hand |
| See what differs | `chezmoi status` / `chezmoi diff` |
| After `pixi global install foo` | `chezmoi re-add ~/.pixi/manifests/pixi-global.toml` |
| Pull and apply on another machine | `chezmoi update` |
| Commit | `chezmoi cd` then `git commit` / `git push` |
| Update rofi themes | change the commit SHA in `chezmoi_config/.chezmoiexternal.toml`, then `chezmoi apply` |

`chezmoi re-add` skips templates: `.zshrc`, `.tmux.conf`, `alacritty.toml` and `lsp.lua`. Edit those in `chezmoi_config/` directly.

## Key bindings

### Tmux (prefix = Ctrl+a)

| Key | Action |
|-----|--------|
| `prefix + w` | Window switcher (fzf, `Ctrl+K` kills window) |
| `prefix + s` | Session switcher (fzf, `Ctrl+K` kills session) |
| `prefix + m` | Rename window |
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

### Rofi (GNOME custom shortcuts, set by hand in Settings > Keyboard)

| Key | Command |
|-----|---------|
| `Alt + r` | `~/.config/rofi/launchers/type-1/launcher.sh` |
| `Alt + Shift + r` | `rofi -show window -theme ~/.config/rofi/launchers/type-1/style-6.rasi` |
| `Alt + Return` | `alacritty` |

### Shell aliases

| Alias | Command |
|-------|---------|
| `ls` | `eza -a --group-directories-first --icons=auto` |
| `ll` | `eza -al --group-directories-first --icons=auto` |
| `ld` | `eza -D --icons=auto` (directories only) |
| `lt` | `eza -a --sort=modified --icons=auto` |
| `src` | `source ~/.zshrc` |
| `zconf` | `nvim ~/.zshrc` |
| `gst` | `~/scripts/git-script/pretty-status` (only if the script exists) |
| `kcli` | `kiro-cli --v3` |
| `atlas`, `m3be`, `mcli`, `atlas-update` | M3 / Atlas shortcuts (work machines only) |

## File structure

```
dotfiles-aws/
├── .chezmoiroot                      (source state lives in chezmoi_config/)
├── install.sh                        bootstrap
├── README.md
└── chezmoi_config/
    ├── .chezmoi.toml.tmpl            init prompts -> ~/.config/chezmoi/chezmoi.toml
    ├── .chezmoiexternal.toml         rofi themes + fonts (downloaded, not committed)
    ├── .chezmoiscripts/              pixi / pixi global sync / prezto / tpm / fc-cache
    ├── dot_zshrc.tmpl                -> ~/.zshrc
    ├── dot_zprofile                  -> ~/.zprofile
    ├── dot_zpreztorc                 -> ~/.zpreztorc
    ├── dot_p10k.zsh                  -> ~/.p10k.zsh
    ├── dot_tmux.conf.tmpl            -> ~/.tmux.conf
    ├── dot_pixi/manifests/pixi-global.toml -> ~/.pixi/manifests/pixi-global.toml
    ├── dot_local/private_share/fonts/ keeps ~/.local/share at mode 700
    ├── scripts/git-script/           -> ~/scripts/git-script
    └── dot_config/
        ├── nvim/                     -> ~/.config/nvim
        ├── alacritty/                -> ~/.config/alacritty
        ├── eza/                      -> ~/.config/eza (shared ls/eza colors)
        ├── lazygit/                  -> ~/.config/lazygit
        └── rofi/                     local overrides on top of the rofi external
```

## Restore a backup

```bash
ls ~/.dotfiles-backup/
cp -p ~/.dotfiles-backup/<timestamp>/.zshrc ~/
```
