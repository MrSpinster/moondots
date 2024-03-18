#  ████████  ████████ ██      ██ ███████     ██████
# ░░░░░░██  ██░░░░░░ ░██     ░██░██░░░░██   ██░░░░██
#      ██  ░██       ░██     ░██░██   ░██  ██    ░░
#     ██   ░█████████░██████████░███████  ░██
#    ██    ░░░░░░░░██░██░░░░░░██░██░░░██  ░██
#   ██            ░██░██     ░██░██  ░░██ ░░██    ██
#  ████████ ████████ ░██     ░██░██   ░░██ ░░██████
# ░░░░░░░░ ░░░░░░░░  ░░      ░░ ░░     ░░   ░░░░░░
#
# Download zsh-snap if it doesn't exist.
[[ -r $ZDOTDIR/plugins/znap/znap.zsh ]] ||
git clone --depth 1 -- \
    https://github.com/marlonrichert/zsh-snap.git $ZDOTDIR/plugins/znap
source $ZDOTDIR/plugins/znap/znap.zsh

function source-rcs() {
    setopt extended_glob

    local -a zshrcd=()
    [[  -n "$ZDOTDIR"  ]] && zshrcd+=(
        $ZDOTDIR/zshrc.d(N)
        $ZDOTDIR/conf.d(N)
        $ZDOTDIR/rc.d(N)
    )
    local -a conf_files=("$zshrcd[1]"/*.{sh,zsh}(N))
    local rcfile
    for rcfile in ${(o)conf_files}; do
    case ${rcfile:t} in '~'*) continue;; esac
            source "$rcfile"
        done
    }
    source-rcs

    znap eval starship 'starship init zsh --print-full-init'
    znap prompt

    znap source kazhala/dotbare
    znap source aloxaf/fzf-tab
    znap source wfxr/forgit
    znap source hlissner/zsh-autopair
    znap source zimfw/asdf

    ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
    znap source zdharma-continuum/fast-syntax-highlighting

    znap function _pyenv pyenv "znap eval pyenv 'pyenv init - --no-rehash'"
    compctl -K    _pyenv pyenv
    eval "$(pyenv virtualenv-init -)"
    source $HOME/.local/share/pyenv/completions/pyenv.zsh

    znap eval zoxide 'zoxide init zsh'

    _dotbare_completion_cmd

    source /home/maestromoon/.config/broot/launcher/bash/br
