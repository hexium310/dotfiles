autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '(%b)' '%c%u'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+'
zstyle ':vcs_info:git:*' untrackedstr '%F{green}?'

precmd() {
    vcs_info
}

_update_vcs_info_msg() {
    local user_host='%B%F{green}%n@%m%f%b'
    local directory='%B%F{blue}%~%f%b'
    local vcs="$vcs_info_msg_1_$vcs_info_msg_0_"
    export PS1=`echo "$user_host $directory $vcs %B%F{blue}$%f%b " | sed -E 's/[[:space:]]+/ /g'`
}

add-zsh-hook precmd _update_vcs_info_msg
