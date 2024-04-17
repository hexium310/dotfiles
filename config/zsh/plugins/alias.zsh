alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -v'
alias chown='chown -v'
alias chmod='chmod -v'
alias mkdir='mkdir -p'
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'
alias sudo='sudo '
alias gpg='LANG=C gpg'
alias vim=${EDITOR-nvim}

if [[ -n $NVIM ]]; then
    alias :q='nvim --server $NVIM --remote-send "<C-\><C-n>:quit<Cr>"'
fi

if (( $+commands[brew] )); then
    alias brwe='brew'
fi

if (( $+commands[docker] )); then
    alias fig='docker compose'
fi

if (( $+commands[clip.exe] )); then
    alias clip='iconv -t UTF-16 | clip.exe'
fi

if [[ `uname` = 'Darwin' ]]; then
    alias ls='ls -G'
elif [[ `uname` = 'Linux' ]]; then
    alias ls='ls -F --color=always'
fi

# Display the files (*.php or *.js) which end with the duplicate new lines under the current directory.
check-file-end() {
    find . -type d \( -name 'node_modules' -o -name 'vendor' \) -prune -o -type f \( -name '*.js' -o -name '*.php' \) -print | while read a; do
        start=$(expr $(wc -c < $a) - 2)
        [[ $start -lt 0 ]] && continue
        new_line=$(hexdump -s $start $a | cut -c 9-13)
        [[ $new_line = '0a 0a' ]] && echo $a
    done
}
