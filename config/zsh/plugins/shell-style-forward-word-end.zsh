autoload -Uz match-words-by-style

shell-style-forward-word-end() {
    local move_count
    local -a matched_words
    local buf_len=${#BUFFER}

    match-words-by-style -w shell

    # Word head
    if [[ -n ${matched_words[3]} ]] && [[ -z ${matched_words[4]} ]] ||
        [[ -z ${matched_words[2]} ]] ||
        [[ ${matched_words[2]} =~ ^\ +$ ]]; then
        move_count=$(( ${#matched_words[5]} - 1 ))
        (( buf_len < move_count )) && return

        (( CURSOR += move_count ))
    # Word tail
    elif (( ${#matched_words[5]} == 2 )) && [[ ${${matched_words[5]}[-1]} = ' ' ]]; then
        move_count=$(( ${#matched_words[5]} ))
        (( buf_len < move_count )) && return
        (( CURSOR += move_count ))

        shell-style-forward-word-end
    # Between words
    elif [[ -n ${matched_words[4]} ]]; then
        move_count=$(( ${#matched_words[4]} + ${#matched_words[5]} - 1 ))
        (( buf_len < move_count )) && return
        (( CURSOR += move_count ))
    # Word tail when current word is quoted and next quoted word
    # aaaaa|a 'bbbbbb'
    elif [[ -n ${matched_words[6]} ]]; then
        move_count=$(( ${#matched_words[4]} + ${#matched_words[5]} + ${#matched_words[6]} - 1 ))
        (( buf_len < move_count )) && return
        (( CURSOR += move_count ))

        shell-style-forward-word-end
    # Word tail when current word quoting whitespace
    # or current word and next word are quated
    # 'aaaaaa |' bbbbbb
    # 'aaaaaa|' 'bbbbbb'
    elif [[ -z ${matched_words[7]} ]] && (( ${#BUFFER} >= $CURSOR + 2 )); then
        move_count=2
        (( buf_len < move_count )) && return
        (( CURSOR += move_count ))

        shell-style-forward-word-end
    # Word body
    else
        move_count=$(( ${#matched_words[2]} ))
        (( CURSOR -= move_count ))

        shell-style-forward-word-end
    fi
}

zle -N shell-style-forward-word-end
