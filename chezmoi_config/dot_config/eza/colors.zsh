# Catppuccin Macchiato, shared by GNU ls and eza.
# Enable color for interactive commands, including when inherited from a tool.
unset NO_COLOR

() {
  local blue='38;2;138;173;244' green='38;2;166;218;149'
  local teal='38;2;139;213;202' mauve='38;2;198;160;246'
  local yellow='38;2;238;212;159' peach='38;2;245;169;127'
  local red='38;2;237;135;150' text='38;2;202;211;245'
  local muted='38;2;128;135;162' ext

  export LS_COLORS="rs=0:fi=${text}:di=1;${blue}:ln=${teal}:ex=${green}:pi=${yellow}:so=${mauve}:bd=${peach}:cd=${peach}:or=1;${red}:mi=${red}:su=${red}:sg=${peach}:tw=1;${blue}:ow=1;${blue}:st=1;${blue}"
  for ext in zip tar gz bz2 xz zst 7z rar tgz deb rpm; do
    LS_COLORS+=":*.$ext=${peach}"
  done
  for ext in jpg jpeg png gif svg webp avif ico mp4 mkv mov webm; do
    LS_COLORS+=":*.$ext=${mauve}"
  done
  for ext in mp3 flac wav ogg opus m4a; do
    LS_COLORS+=":*.$ext=${teal}"
  done
  for ext in md txt pdf epub doc docx odt; do
    LS_COLORS+=":*.$ext=${yellow}"
  done
  for ext in py rs go js jsx ts tsx c h cpp lua sh zsh; do
    LS_COLORS+=":*.$ext=${green}"
  done
  for ext in json yaml yml toml ini conf xml; do
    LS_COLORS+=":*.$ext=${teal}"
  done
  for ext in bak old tmp swp; do
    LS_COLORS+=":*.$ext=${muted}"
  done

  # eza-specific file categories and long-listing metadata.
  export EZA_COLORS="di=1;${blue}:fi=${text}:ln=${teal}:ex=${green}:or=${red}:im=${mauve}:vi=${mauve}:mu=${teal}:lo=${peach}:do=${yellow}:co=${muted}:da=${muted}:uu=${mauve}:gu=${teal}"
}
