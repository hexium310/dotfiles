if (( $+commands[direnv] )); then
    source <(direnv hook zsh)
    export DIRENV_LOG_FORMAT=
fi
