autoload -Uz vcs_info

zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:git:*' formats '%c%u' '(%b)'
zstyle ':vcs_info:git:*' actionformats '%c%u' '(%b)' ':%a'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+%f'
zstyle ':vcs_info:git:*' untrackedstr '%F{green}?%f'

precmd() {
    LANG=en_US.UTF-8 vcs_info
}

_zsh_prompt_redraw() {
    if [[ $WIDGET =~ finish ]]; then
        _zsh_prompt 'finish'
        return
    fi

    case $KEYMAP in
        main)
            _zsh_prompt 'insert'
            ;;
        vicmd)
            _zsh_prompt 'normal'
            ;;
        vivis|vivli)
            _zsh_prompt 'visual'
            ;;
        *)
            _zsh_prompt $KEYMAP
            ;;
    esac
}

_zsh_prompt() {
    local suffix
    local vcs_info_msg
    local user_host='%F{green}%n@%m%f'
    local directory='%F{blue}%2~%f'

    [[ -n $vcs_info_msg_0_ ]] && vcs_info_msg+=$vcs_info_msg_0_
    [[ -n $vcs_info_msg_1_ ]] && vcs_info_msg+="%F{blue}$vcs_info_msg_1_%f"
    [[ -n $vcs_info_msg_2_ ]] && vcs_info_msg+="%F{red}$vcs_info_msg_2_%f"

    case $1 in
        insert)
            suffix='%K{blue}%F{#393939} $ %f%k'
            ;;
        visual)
            suffix='%K{magenta}%F{#393939} $ %f%k'
            ;;
        normal)
            suffix='%K{green}%F{#393939} $ %f%k'
            ;;
        finish)
            suffix='%K{#898989}%F{#393939} $ %f%k'
            user_host='%F{#89b789}%n@%m%f'
            directory='%F{#5b89b7}%2~%f'
            vcs_info_msg=${vcs_info_msg//\{blue\}/\{#5b89b7\}}
            vcs_info_msg=${vcs_info_msg//\{red\}/\{#d96b6d\}}
            vcs_info_msg=${vcs_info_msg//\{green\}/\{#89b789\}}
            vcs_info_msg=${vcs_info_msg//\{yellow\}/\{#e5b75b\}}
            ;;
        *)
            suffix='%K{blue}%F{#393939} $ %f%k'
            ;;
    esac

    PROMPT="%B$user_host $directory $vcs_info_msg $suffix %b"
    zle reset-prompt
}

zle -N zle-line-init _zsh_prompt_redraw
zle -N zle-line-finish _zsh_prompt_redraw
zle -N zle-keymap-select _zsh_prompt_redraw
export PROMPT=''
