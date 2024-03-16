#  ████████           ██             ██                
# ░░░░░░██           ░██    ██   ██ ░██                
#      ██    ██████ ██████ ░░██ ██  ░██  █████   ██████
#     ██    ██░░░░ ░░░██░   ░░███   ░██ ██░░░██ ██░░░░ 
#    ██    ░░█████   ░██     ░██    ░██░███████░░█████ 
#   ██      ░░░░░██  ░██     ██     ░██░██░░░░  ░░░░░██
#  ████████ ██████   ░░██   ██      ███░░██████ ██████ 
# ░░░░░░░░ ░░░░░░     ░░   ░░      ░░░  ░░░░░░ ░░░░░░  
#

#█▓▒░ Case insensitive (all), partial-word, and then substring completion
zstyle ':completion:*' matcher-list  'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=* r:|=*'
unsetopt CASE_GLOB

#█▓▒░ Use caching for longer completions
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

#█▓▒░Colorscript completion
compdef '_files -W "$HOME/bin/colorscripts"' colorscript

#█▓▒░ Defaults.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

#█▓▒░ Group matches and describe
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*options' description 'yes'
zstyle ':completion:*options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

#█▓▒░ Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

#█▓▒░ History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

#█▓▒░ Environment Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

#█▓▒░ Array completion element sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
