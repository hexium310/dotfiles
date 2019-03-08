[[ $- == *i* ]] && source $(dirname $(dirname $(which brew)))/opt/fzf/shell/completion.zsh 2> /dev/null

# TODO: Implement history search
source $(dirname $(dirname $(which brew)))/opt/fzf/shell/key-bindings.zsh 2> /dev/null

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
