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
            _zsh_prompt 'normal'
            ;;
    esac
}

_zsh_prompt() {
    typeset -A format
    local hostname="${${HOST:#*.local}:+%m }"

    format[normal-prefix]='%B%K{#2d2d2d}%F{#2d2d2d}[%f'
    format[normal-hostname]="%F{green}$hostname%f"
    format[normal-directory]='%F{blue}%1~%f '
    format[normal-vcs-0]='%s'
    format[normal-vcs-1]='%%F{blue}%s%%f'
    format[normal-vcs-2]='%%F{red}%s%%f'
    format[normal-suffix]='%K{green}%F{#393939} $%F{green}]%f%k%b '

    format[insert-prefix]="${format[normal-prefix]}"
    format[insert-hostname]="${format[normal-hostname]}"
    format[insert-directory]="${format[normal-directory]}"
    format[insert-vcs-0]="${format[normal-vcs-0]}"
    format[insert-vcs-1]="${format[normal-vcs-1]}"
    format[insert-vcs-2]="${format[normal-vcs-2]}"
    format[insert-suffix]='%K{blue}%F{#393939} $%F{blue}]%f%k%b '

    format[visual-prefix]="${format[normal-prefix]}"
    format[visual-hostname]="${format[normal-hostname]}"
    format[visual-directory]="${format[normal-directory]}"
    format[visual-vcs-0]="${format[normal-vcs-0]}"
    format[visual-vcs-1]="${format[normal-vcs-1]}"
    format[visual-vcs-2]="${format[normal-vcs-2]}"
    format[visual-suffix]='%K{magenta}%F{#393939} $%F{magenta}]%f%k%b '

    format[finish-prefix]="${format[normal-prefix]}"
    format[finish-hostname]="%F{#5b7a5b}$hostname%f"
    format[finish-directory]='%F{#3d5b7a}%1~%f '
    format[finish-vcs-0]="${format[normal-vcs-0]}"
    format[finish-vcs-1]='%%F{#3d5b7a}%s%%f'
    format[finish-vcs-2]='%%F{#914749}%s%%f'
    format[finish-suffix]='%K{#515151}%F{#242424} $%F{#515151}]%f%k%b '

    local vcs_info
    local prefix="${=format[$1-prefix]}"
    local hostname="${=format[$1-hostname]}"
    local directory="${=format[$1-directory]}"
    local vcs0="${=format[$1-vcs-0]}"
    local vcs1="${=format[$1-vcs-1]}"
    local vcs2="${=format[$1-vcs-2]}"
    local suffix="${=format[$1-suffix]}"

    [[ -n $vcs_info_msg_0_ ]] && vcs_info+=$(printf "$vcs0" "$vcs_info_msg_0_")
    [[ -n $vcs_info_msg_1_ ]] && vcs_info+=$(printf "$vcs1" "$vcs_info_msg_1_")
    [[ -n $vcs_info_msg_2_ ]] && vcs_info+=$(printf "$vcs2" "$vcs_info_msg_2_")
    [[ -n $vcs_info ]] && vcs_info+=' '

    if [[ $1 = finish ]]; then
        vcs_info=${vcs_info//\{red\}/\{#914749\}}
        vcs_info=${vcs_info//\{green\}/\{#5b7a5b\}}
        vcs_info=${vcs_info//\{yellow\}/\{#997a3d\}}
    fi

    PROMPT="$prefix$hostname$directory$vcs_info$suffix"
    zle reset-prompt
}

zle -N zle-line-init _zsh_prompt_redraw
zle -N zle-line-finish _zsh_prompt_redraw
zle -N zle-keymap-select _zsh_prompt_redraw
export PROMPT=''

if [[ -n $NVIM ]]; then
    __neovim_set_pwd() {
        ( nvim -l $ZDOTDIR/plugins/nvim_terminal.lua cd & ) > /dev/null
    }

    add-zsh-hook chpwd __neovim_set_pwd
    __neovim_set_pwd
fi
