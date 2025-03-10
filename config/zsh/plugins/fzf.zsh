autoload -U colors
colors

fzf-history() {
    local history_num=($(
        fc -rl 1 |
        awk '
            {
                num = $1;
                $1 = "";
                if (list_for_skipping_duplication[$0]++) {
                    next
                }
                printf "%6s %s\n", num, $0;
            }
        ' |
        fzf --reverse --query=$LBUFFER --tiebreak=index --no-sort --bind=ctrl-r:toggle-sort --nth 2.. |
        awk '{ print $1 }'
    ))
    [[ -n "$history_num" ]] && zle vi-fetch-history -n $history_num

    zle reset-prompt
}

zle -N fzf-history
bindkey -M viins '^R' fzf-history

_fzf_complete_vim() {
    if (( $+functions[_fzf_complete_git] )) && [[ $prefix =~ '\*$' ]]; then
        prefix=${prefix%\*}
        _fzf_complete_git-status-files unstaged '' "--multi $_fzf_complete_preview_git_diff" $@
        return
    fi

    _fzf_path_completion "$prefix" $@
}

_fzf_complete_nvim() {
    _fzf_complete_vim $@
}

_fzf_compgen_path() {
    fd . "$1" --hidden --type=file --exclude={${(pj:,:)$(git submodule status | awk '{ print $2 }')}} 2> /dev/null
}

_fzf_compgen_dir() {
    fd . "$1" --hidden --type=directory 2> /dev/null
}
