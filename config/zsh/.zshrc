[[ -a "$ZPLUG_HOME" ]] && {
    source "$ZPLUG_HOME/init.zsh"

    zplug 'chitoku-k/zsh-reset-title'
    zplug 'chitoku-k/zsh-vcs-extended'
    zplug 'chitoku-k/zsh-togglecursor', defer:1

    zplug "$ZDOTDIR/plugins", from:local
    zplug "$ZDOTDIR/local", from:local

    if ! zplug check; then
        printf 'Install? [y/N]: '
        if read -q; then
            echo; zplug install
        fi
    fi

    zplug load
}
