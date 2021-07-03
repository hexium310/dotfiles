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
alias fd='fd --ignore-file=$XDG_CONFIG_HOME/fdignore'
alias gpg='LANG=C gpg'
(( $+commands[nvim] )) && alias vim='nvim'

if (( $+commands[nvim] )); then
    export MANPAGER='nvim +Man!'
    if [[ -n $NVIM_LISTEN_ADDRESS ]]; then
        export MANPAGER='python3 $ZDOTDIR/plugins/man.py'
    fi
fi

if [[ -n $NVIM_LISTEN_ADDRESS ]] && (( $+commands[nvr] )); then
    alias vim='nvr --remote-tab'
    alias :q='nvr --remote-send "<C-\><C-n>:quit<Cr>"'
fi

if (( $+commands[brew] )); then
    alias brwe='brew'
fi

if (( $+commands[docker-compose] )); then
    alias fig='docker-compose'
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
