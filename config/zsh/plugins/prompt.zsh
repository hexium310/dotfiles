autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{blue}(%b)' '%c%u'
zstyle ':vcs_info:*' actionformats '%F{blue}(%b|%a)'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+'
zstyle ':vcs_info:git:*' untrackedstr '%F{green}?'

precmd() {
    vcs_info
}

_update_vcs_info_msg() {
    local user_host='%F{green}%n@%m%f'
    local directory='%F{blue}%~%f'
    local vcs="$vcs_info_msg_1_$vcs_info_msg_0_"
    #echo "$user_host $directory $vcs %B%F{blue}$%f%b " | sed -E 's/[[:space:]]+/ /g'
    export PS1=`echo "%B$user_host $directory $vcs %F{blue}$%f %b" | sed -E 's/[[:space:]]+/ /g'`
}

add-zsh-hook precmd _update_vcs_info_msg
