[[ $- == *i* ]] && source $(dirname $(dirname $(which brew)))/opt/fzf/shell/completion.zsh 2> /dev/null

fzf-select-git-files() {
    local file=$(git ls-files . -co --exclude-standard 2> /dev/null | fzf)
    [[ -n "$file" ]] && LBUFFER="$LBUFFER$file "

    zle reset-prompt
}

zle -N fzf-select-git-files
bindkey '^P' fzf-select-git-files

fzf-select-all-files() {
    local file=$(fd --hidden --exclude=.git/ --type=file --type=directory --color=always 2> /dev/null | fzf -m)
    [[ -n "$file" ]] && LBUFFER="$LBUFFER$file "

    zle reset-prompt
}

zle -N fzf-select-all-files
bindkey '^T' fzf-select-all-files

fzf-history() {
    local command=( $(history 1 \
      | tail -r \
      | awk '{c="";for(i=2;i<NF;i++){c=c sprintf("%s ",$i);}c=c $NF;if(!a[c]++){printf(" %6s%s\n", substr($1, length($1), 1)=="*"?$1" ":$1"  ",c)}}' \
      | fzf --query=${LBUFFER} +s --bind=ctrl-r:toggle-sort) )
    [[ -n "$command[1]" ]] && zle vi-fetch-history -n $command[1]

    zle reset-prompt
}

zle -N fzf-history
bindkey '^R' fzf-history
