#
# Prezto
#
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# PATH
#
export PATH="$HOME/.fzf/bin:$HOME/.pixi/bin:$PATH:/opt/nvim-linux-x86_64/bin"

#
# Aliases
#
# Grep: use underline + bold blue for matches (readable on dark backgrounds)
export GREP_COLORS='ms=01;34:mc=01;34:sl=:cx=:fn=35:ln=32:bn=32:se=36'

alias ls='eza -a --group-directories-first --icons'
alias ll='eza -al --group-directories-first --icons'
alias ld='eza -D --icons'
alias lf='eza -f --color=always'
alias lh='eza -d .* --group-directories-first --icons'
alias lt='eza -a --sort=modified --icons'

alias atlas-update='cd ~/atlas && git pull && uv sync && uv run atlas-trunk-sync --yes'
alias src='source ~/.zshrc'
alias zconf='nvim ~/.zshrc'

alias mak='cd ~/iMAK/WORKSPACE-m3be-iMAKDevSDA/SW/'
alias m3be='cd ~/iMAK/M3BE && nvim .'
alias atlas='cd ~/atlas/'

#
# Zoxide
#
eval "$(zoxide init zsh)"

#
# fzf - use ~/.fzf/bin version (supports --zsh)
#
source <(~/.fzf/bin/fzf --zsh)

#
# Kiro shell integration
#
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

#
# Terminal-specific settings
#
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  export TERM=xterm-ghostty
fi
