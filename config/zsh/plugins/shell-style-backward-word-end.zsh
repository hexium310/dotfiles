autoload -Uz match-words-by-style
autoload -Uz backward-word-match

shell-style-backward-word-end() {
    local move_count
    local -a matched_words

    match-words-by-style -w shell

    if [[ -n ${matched_words[3]} ]] && [[ -z ${matched_words[4]} ]] ||
        [[ -z ${matched_words[2]} ]] ||
        [[ ${matched_words[2]} =~ ^\ +$ ]]; then
        backward-word-match
        shell-style-forward-word-end
    elif [[ -z ${matched_words[7]} ]] && (( ${#BUFFER} >= $CURSOR + 2 )) || [[ -n ${matched_words[6]} ]]; then
        backward-word-match
        backward-word-match
        backward-word-match
        shell-style-forward-word-end
    else
        backward-word-match
        backward-word-match
        shell-style-forward-word-end
    fi
}

zle -N shell-style-backward-word-end
