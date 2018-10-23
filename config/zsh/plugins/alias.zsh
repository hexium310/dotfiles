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

if (( $+commands[brew] )); then
    alias brwe='brew'
fi

if (( $+commands[docker-compose] )); then
    alias fig='docker-compose'
fi

if (( $+commands[nvim] )); then
    alias vim='nvim'
fi

if [[ `uname` = 'Darwin' ]]; then
    alias ls='ls -G'
elif [[ `uname` = 'Linux' ]]; then
    alias ls='ls -F --color=always'
fi
