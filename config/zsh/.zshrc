[[ -d "$ZPLG_HOME" ]] && {
    source $XDG_CACHE_HOME/zplugin/bin/zplugin.zsh
    autoload -Uz _zplugin
    (( ${+_comps} )) && _comps[zplugin]=_zplugin

    set_autosuggestions_env() {
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247,underline"
    }

    zplugin light chitoku-k/zsh-togglecursor
    zplugin ice atload'set_autosuggestions_env'; zplugin light zsh-users/zsh-autosuggestions
    zplugin ice lucid wait'0'; zplugin light chitoku-k/zsh-reset-title
    zplugin ice lucid wait'0'; zplugin light chitoku-k/zsh-vcs-extended
    zplugin ice lucid wait'0'; zplugin light zsh-users/zsh-completions
    zplugin ice lucid wait'0' atload'zpcompinit; zpcdreplay'; zplugin light zdharma/fast-syntax-highlighting

    zplugin ice atinit'local i; for i in *.zsh; do source $i; done'; zplugin light $ZDOTDIR/plugins
    zplugin light $ZDOTDIR/local
    zplugin ice has'fzf'; zplugin light $ZDOTDIR/plugins/fzf

    unfunction set_autosuggestions_env
}
