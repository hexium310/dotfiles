[[ -a "$ZPLUG_HOME" ]] && {
    source "$ZPLUG_HOME/init.zsh"

    zplug 'chitoku-k/zsh-reset-title'
    zplug 'chitoku-k/zsh-vcs-extended'
    zplug 'chitoku-k/zsh-togglecursor', defer:1
    zplug 'zsh-users/zsh-syntax-highlighting', defer:2
    zplug 'zsh-users/zsh-completions', lazy:true

    zplug "$ZDOTDIR/plugins", from:local
    zplug "$ZDOTDIR/local", from:local

    zplug check || zplug install
    zplug load
}
