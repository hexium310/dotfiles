[[ -d "$ZPLG_HOME" ]] && {
    source $XDG_CACHE_HOME/zinit/bin/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    set_autosuggestions_env() {
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247,underline"
    }

    zinit light chitoku-k/zsh-togglecursor
    zinit ice atload'set_autosuggestions_env'; zinit light zsh-users/zsh-autosuggestions
    zinit ice lucid wait'0'; zinit light chitoku-k/zsh-reset-title
    zinit ice lucid wait'0'; zinit light chitoku-k/zsh-vcs-extended
    zinit ice lucid wait'0'; zinit light zsh-users/zsh-completions
    zinit ice lucid wait'0' pick'src/git.zsh'; zinit light chitoku-k/fzf-zsh-completions
    zinit ice lucid wait'0' atload'zpcompinit; zpcdreplay'; zinit light zdharma/fast-syntax-highlighting

    zinit ice lucid wait'0' from'gh' atclone'./install --bin' atpull'%atclone' as'program' src'shell/completion.zsh' pick'bin/fzf'; zinit light junegunn/fzf
    zinit ice lucid wait'0' from'gh-r' as'program' pick'ripgrep*/rg'; zinit light BurntSushi/ripgrep
    zinit ice lucid wait'0' from'gh-r' as'program' pick'fd*/fd'; zinit light sharkdp/fd
    zinit ice lucid wait'0' from'gh-r' as'program' pick'nvim*/bin/nvim'; zinit light neovim/neovim

    zinit ice atinit'local i; for i in *.zsh; do source $i; done'; zinit light $ZDOTDIR/plugins
    zinit light $ZDOTDIR/local

    unfunction set_autosuggestions_env
}
