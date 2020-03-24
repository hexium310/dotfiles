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

fzf-github-repositories() {
    local repositories_path="~/Repositories/"
    local repo=$(fd -HI --type=directory --maxdepth=1 . ~/Repositories/hexium310 | cut -d "/" -f 5- | fzf)
    [[ -n $repo ]] && LBUFFER="$LBUFFER$repositories_path$repo "

    zle reset-prompt
}

zle -N fzf-github-repositories
bindkey -M viins '^G' fzf-github-repositories
bindkey -M vicmd '^G' fzf-github-repositories

_fzf_complete_vim() {
    if (( $+functions[_fzf_complete_git] )) && [[ $prefix =~ '\*$' ]]; then
        prefix=${prefix%\*}
        _fzf_complete_git-unstaged-files '' "--multi $_fzf_complete_preview_git_diff" $@
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

_fzf_complete_zinit() {
    local arguments=${(Q)${(z)@}}
    local subcommand=${${(Q)${(z)arguments}}[2]}

    if [[ $subcommand =~ ^(cd|delete|status|update)$ ]]; then
        _fzf_complete '--ansi --multi' $@ < <({
            local plugins=(${ZINIT[PLUGINS_DIR]}/*(N:t))
            plugins=(${plugins[@]//---/\/})
            plugins=(${plugins[@]:#_local/zinit})
            plugins=(${plugins[@]:#custom})
            plugins=($fg_bold[magenta]${^plugins/\//$reset_color\/$fg_bold[yellow]}$reset_color)
            echo ${(F)plugins}
        })
        return
    fi
}
