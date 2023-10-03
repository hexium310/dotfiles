autoload -Uz add-zsh-hook

setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
setopt extended_history

HISTFILE=~/.config/zsh/.zsh_history
SAVEHIST=100000
HISTSIZE=100000

__check_syntax_error() {
    local argument=${@%%$'\n'}

    local error
    error=$(zsh -cn "$argument" 2>&1)
    local code=$?

    if (( $code )) && [[ $error != 'zsh:1: no directory expansion: '* ]]; then
        return 1
    fi
}

add-zsh-hook zshaddhistory __check_syntax_error

__ignore_shorter_command() {
    local arguments=(${(Q)${(z)${@%%$'\n'}}})

    if (( ${#arguments} == 1 )) && (( ${#${arguments[1]}} <= 5 )); then
        return 2
    fi
}

add-zsh-hook zshaddhistory __ignore_shorter_command
