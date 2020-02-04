#!/usr/bin/env zsh

_fzf_complete_pushd() {
    _fzf_complete '--tiebreak=index' "$@" < <(
        \dirs -p | awk \
            -v current_dir="$(pwd)" \
            -v home="$HOME" '
                {
                    gsub(home, "~", current_dir)
                    if ($0 == current_dir) {
                        next
                    }
                    print
                }
            '
        )
    return
}
