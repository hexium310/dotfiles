autoload -Uz vcs_info add-zsh-hook

zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:git:*' formats '%c%u' '(%b)'
zstyle ':vcs_info:git:*' actionformats '%c%u' '(%b)' ':%a'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+%f'
zstyle ':vcs_info:git:*' untrackedstr '%F{green}?%f'

# vcs_info command is executed by chitoku-k/zsh-vcs-extended

_zsh_prompt_redraw() {
    if [[ $WIDGET = zle-line-finish ]]; then
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
    local host
    local directory='%F{blue}%1~%f'
    if [[ $HOST != *.local ]]; then
        host='%m '
    fi
    local colored_host="%F{green}$host%f"

    local dark_blue='#3d5b7a'
    local dark_red='#914749'
    local dark_green='#5b7a5b'
    local dark_yellow='#997a3d'

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
            suffix='%K{#515151}%F{#242424} $ %f%k'
            colored_host="%F{#$dark_green}$host%f"
            directory="%F{$dark_blue}%1~%f"
            vcs_info_msg=${vcs_info_msg//\{blue\}/\{$dark_blue\}}
            vcs_info_msg=${vcs_info_msg//\{red\}/\{$dark_red\}}
            vcs_info_msg=${vcs_info_msg//\{green\}/\{$dark_green\}}
            vcs_info_msg=${vcs_info_msg//\{yellow\}/\{$dark_yellow\}}
            ;;
        *)
            suffix='%K{blue}%F{#393939} $ %f%k'
            ;;
    esac

    if [[ -z $vcs_info_msg ]]; then
        PROMPT="%B$colored_host$directory $suffix %b"
    else
        PROMPT="%B$colored_host$directory $vcs_info_msg $suffix %b"
    fi
    zle reset-prompt
}

zle -N zle-line-init _zsh_prompt_redraw
zle -N zle-line-finish _zsh_prompt_redraw
zle -N zle-keymap-select _zsh_prompt_redraw
export PROMPT=''

if [[ -n $NVIM_LISTEN_ADDRESS ]]; then
    __neovim_set_pwd() {
        ( $ZDOTDIR/plugins/terminal.py cd & ) > /dev/null
    }

    add-zsh-hook chpwd __neovim_set_pwd
    __neovim_set_pwd
fi
