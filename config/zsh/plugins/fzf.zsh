fzf-history() {
    local command=( $(history 1 \
      | tail -r \
      | awk '{c="";for(i=2;i<NF;i++){c=c sprintf("%s ",$i);}c=c $NF;if(!a[c]++){printf(" %6s%s\n", substr($1, length($1), 1)=="*"?$1" ":$1"  ",c)}}' \
      | fzf --query=${LBUFFER} +s --bind=ctrl-r:toggle-sort) )
    [[ -n "$command[1]" ]] && zle vi-fetch-history -n $command[1]

    zle reset-prompt
}

zle -N fzf-history
bindkey -M 'emacs' '^R' fzf-history

fzf-github-repositories() {
    local repositories_path="~/Repositories/"
    local repo=$(fd -HI --type=directory --maxdepth=1 . ~/Repositories/hexium310 | cut -d "/" -f 5- | fzf)
    [[ -n $repo ]] && LBUFFER="$LBUFFER$repositories_path$repo "

    zle reset-prompt
}

zle -N fzf-github-repositories
bindkey -M 'emacs' '^G' fzf-github-repositories

_fzf_complete_yarn() {
    if [[ "$@" = 'yarn'* ]] || [[ "$@" = 'yarn run'* ]]; then
        _fzf_complete '--ansi' "$@" < <(
            yarn run 2> /dev/null |
            awk -F ',' '
            NR == 2 {
                gsub(/^.+: /, "")
                gsub(/, /, "\n")
                binaries = $0
            }
            /^ +-/ {
                gsub(/^ +- /, "")
                command = $0
                getline
                gsub(/^ +/, "")
                projects[(NR - 1) / 2 - 1] = sprintf("%s,%s", command, $0)
            }
            END {
                for (i = 1; i <= length(projects); ++i) {
                    print projects[i]
                }
                print binaries
            }
            ' |
            _fzf_complete_yarn_tabularize
        )
        return
    fi

    zle ${fzf_default_completion:-expand-or-complete}
}

_fzf_complete_yarn_post() {
    awk '
    {
        if ($1 ~ /\x27/) {
            for (i = 2; i <= NF; ++i) {
                if ($i !~ /\x27/) {
                    continue
                }
                for (j = 1; j <= i; ++j) {
                    str = str " " $j
                }
                break
            }
        } else {
            str = $1
        }

        sub("^ ", "", str)
        print str
    }
    '
}

_fzf_complete_yarn_tabularize() {
    awk \
        -F ',' \
        -v yellow="$(tput setaf 3)" \
        -v reset="$(tput sgr0)" '
        {
            refnames[NR] = $1
            if (length($1) > refname_max) {
                refname_max = length($1)
            }
            $1 = ""
            messages[NR] = $0
        }
        END {
            for (i = 1; i <= length(refnames); ++i) {
                printf "%s%-" refname_max "s%s %s\n", yellow, refnames[i] ~ / / ? "\x27" refnames[i] "\x27" : refnames[i], reset, messages[i]
            }
        }
    '
}

_fzf_compgen_path() {
    fd . "$1" --hidden --type=file 2> /dev/null
}

_fzf_compgen_dir() {
    fd . "$1" --hidden --type=directory 2> /dev/null
}