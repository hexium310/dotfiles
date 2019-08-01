[[ -d "$ZPLG_HOME" ]] && {
    source $XDG_CACHE_HOME/zplugin/bin/zplugin.zsh
    autoload -Uz _zplugin
    (( ${+_comps} )) && _comps[zplugin]=_zplugin

    zplugin light chitoku-k/zsh-togglecursor
    zplugin light zsh-users/zsh-autosuggestions
    zplugin ice lucid wait'0'; zplugin light chitoku-k/zsh-reset-title
    zplugin ice lucid wait'0'; zplugin light chitoku-k/zsh-vcs-extended
    zplugin ice lucid wait'0'; zplugin light zsh-users/zsh-completions
    zplugin ice lucid wait'0' atload'zpcompinit; zpcdreplay'; zplugin light zdharma/fast-syntax-highlighting

    zplugin ice atinit'local i; for i in *.zsh; do source $i; done'; zplugin light $ZDOTDIR/plugins
    zplugin ice atinit'local i; for i in *.zsh; do source $i; done'; zplugin light $ZDOTDIR/local
    zplugin ice has'fzf' atinit'source *.zsh'; zplugin light $ZDOTDIR/plugins/fzf
}
