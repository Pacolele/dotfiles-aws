#
# Executes commands at login pre-zshrc.
#
# Prezto default zprofile
#

# Browser
if [[ -z "$BROWSER" && "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Less options
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Paths
typeset -gU cdpath fpath mailpath path

path=(
  $HOME/.fzf/bin
  $HOME/.pixi/bin
  $HOME/.local/bin
  /usr/local/{bin,sbin}
  $path
)
