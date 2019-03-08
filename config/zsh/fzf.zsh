[[ $- == *i* ]] && source $(dirname $(dirname $(which brew)))/opt/fzf/shell/completion.zsh 2> /dev/null

fzf-edit-file() {
    local file=$(find -E . -mindepth 1 \( -type f -o -type l \) -not -regex ".*/$FZF_IGNORE/.*" 2> /dev/null \
      | cut -b3- | fzf)
    [[ -n "$file" ]] && {
        local cmd="${EDITOR:-vim} \"$file\""
        eval $cmd
        print -s $cmd
    }

    zle reset-prompt
}

zle -N fzf-edit-file
bindkey '^P' fzf-edit-file

fzf-select-files() {
    local file=$(find -E . -mindepth 1 \( -type f -o -type l -o -type d \) -not -regex ".*/$FZF_IGNORE/?.*" 2> /dev/null \
      | cut -b3- | fzf -m | perl -pe 's/\n/ /m' | sed -e 's/ $//')
    [[ -n "$file" ]] && LBUFFER="$LBUFFER$file "

    zle reset-prompt
}

zle -N fzf-select-files
bindkey '^T' fzf-select-files

fzf-history() {
    local command=( $(history 1 \
      | tail -r \
      | awk '{c="";for(i=2;i<NF;i++){c=c sprintf("%s ",$i);}c=c $NF;if(!a[c]++){printf(" %6s%s\n", substr($1, length($1), 1)=="*"?$1" ":$1"  ",c)}}' \
      | fzf --query=${LBUFFER}) )
    [[ -n "$command[1]" ]] && zle vi-fetch-history -n $command[1]

    zle reset-prompt
}

zle -N fzf-history
bindkey '^R' fzf-history
