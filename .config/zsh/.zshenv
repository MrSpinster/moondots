#█▓▒░ General environment settings
export EDITOR=nvim

#█▓▒░ Pyenv settings
export PYENV_ROOT="$HOME/.local/share/pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

#█▓▒░ Asdf settings
export ASDF_DIR="$HOME/.local/share/asdf"
export ASDF_CONFIG_FILE="$HOME/.config/asdf/asdfrc"
export ASDF_DATA_DIR="$HOME/.cache/asdf"

#█▓▒░ Dotbare
export DOTBARE_DIR="$HOME/.config/dotfiles"
export DOTBARE_BACKUP="${XDG_DATA_HOME:-$HOME/.local/share}/dotbare"
export DOTBARE_PREVIEW="bat --color=always -n {}"
export DOTBARE_KEY="
--bind=alt-a:toggle-all
--bind=alt-j:jump
--bind=alt-0:top
--bind=alt-s:toggle-sort
--bind=alt-t:toggle-preview
"
export DOTBARE_FZF_DEFAULT_OPTS=" \
--color=bg:#1e1e2e,bg+:#262626,hl:#f38ba8,hl+:#5fd7ff \
--color=fg:#cdd6f4,fg+:#d0d0d0,header:#f38ba8,info:#cba6f7 \
--color=marker:#f5e0dc,prompt:#cba6f7,spinner:#f5e0dc,pointer:#f5e0dc \
--color=border:#262626,label:#aeaeae,query:#d9d9d9 \
--layout=reverse \
--info=inline \
--height=80% \
--multi \
--preview-window=:hidden \
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2>/dev/null | head -200' \
--prompt='∼ ' --pointer='▶' --marker='✓' \
--bind=?:toggle-preview"

#█▓▒░ Set path environment
typeset -U path
path=(
  $HOME/.local/bin
  $HOME/bin
  $ASDF_DIR/bin
  $PYENV_ROOT/bin
  $path[@]
)
export PATH

#█▓▒░ Add our custom completions to fpath
typeset -U fpath
my_functions=$ZDOTDIR/functions
if [[ -z ${fpath[(r)$my_functions]} ]] ; then
  fpath=($my_functions $ZDOTDIR/completions $fpath)
  autoload -Uz ${my_functions}/*(:t)
fi

#█▓▒░ Set LS_COLORS using vivid
export LS_COLORS="$(vivid generate catppuccin-macchiato)"
