# 
# allow hidden files in completions
setopt globdots

#
# set fzf completion trigger
export FZF_COMPLETION_TRIGGER=",,"

#

#####
#fzf default options
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--ansi \
--layout=reverse \
--info=inline \
--height=80% \
--multi \
--preview-window=:hidden \
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2>/dev/null | head -200' \
--prompt='∼ ' --pointer='▶' --marker='✓' \
--bind=?:toggle-preview \
--bind=ctrl-f:jump
"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#cdd6f4,fg+:#d0d0d0,bg:#1e1e2e,bg+:#262626
  --color=hl:#f38ba8,hl+:#5fd7ff,info:#cba6f7,marker:#f5e0dc
  --color=prompt:#cba6f7,spinner:#f5e0dc,pointer:#f5e0dc,header:#f38ba8
  --color=border:#262626,label:#aeaeae,query:#d9d9d9'

# options for fzf <CTRL>t keybind
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

#
# print tree structure in preview window when using <Alt>c to cd
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# wrap command preview when using history widget
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# use ripgrep with fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# ensure these commands are only completed with directories
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"
export FZF_CTRL_T_COMMAND="bfs -color -mindepth 1 -exclude \( -name .git \) -printf '%P\n' 2>/dev/null"
export FZF_ALT_C_COMMAND="bfs -color -mindepth 1 -exclude \( -name .git \) -type d -printf '%P\n' 2>/dev/null"

# use ripgrep for path completion
_fzf_compgen_path() {
     # rg --files --glob "!.git" . "$1"
     bfs -H "$1" -color -exclude \( -name .git \) 2>/dev/null
}
# fd for directory completion
_fzf_compgen_dir() {
     # fd --type d --hidden --follow --exclude ".git" . "$1"
     bfs -H "$1" -color -exclude \( -name .git \) -type d 2>/dev/null
}
#

# start fzf
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}"/fzf/fzf.zsh ] \
     && source "${XDG_DATA_HOME:-$HOME/.local/share}"/fzf/fzf.zsh

source $XDG_DATA_HOME/fzf/shell/completion.zsh
source $XDG_DATA_HOME/fzf/shell/key-bindings.zsh

zle -N _fzf_complete_alias
bindkey '^[t' _fzf_complete_alias

# fzf-tab options
# set description format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# use bat for colorized previews
zstyle ':fzf-tab:complete:*' fzf-preview 'bat $realpath'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory contents with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
# switch groups using `,` and `.`
zstyle ':fzf-tab:*' switch-group '<' '>'
# start with preview window hidden
zstyle ':fzf-tab:complete:*' fzf-flags --preview-window hidden:wrap
# define keybindings 
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-f:jump' 
