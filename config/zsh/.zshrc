() {
    local file
    for file in $ZDOTDIR/{plugins,local}/*.zsh(DN); do
        source $file
    done
}

if [[ -d $ZPLG_HOME ]]; then
    source $ZPLG_HOME/bin/zinit.zsh
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=247,underline"

    rewrite__zsh_togglecursor_reset() {
        _zsh_togglecursor_reset() {
            _zsh_togglecursor_apply_cursor 'line'
        }
    }

    zinit light b4b4r07/zsh-vimode-visual
    zinit light chitoku-k/fzf-zsh-completions
    zinit light chitoku-k/zsh-reset-title
    zinit light chitoku-k/zsh-vcs-extended

    zinit ice lucid  wait'!' atload'rewrite__zsh_togglecursor_reset; unfunction rewrite__zsh_togglecursor_reset'
    zinit light chitoku-k/zsh-togglecursor
    zinit lucid wait'!' for \
        atinit'zpcompinit; zpcdreplay' nocd zdharma/fast-syntax-highlighting \
        blockf zsh-users/zsh-completions \
        atload'!
            ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(fzf-completion vi-cmd-mode history-beginning-search-backward-end history-beginning-search-forward-end);
            ZSH_AUTOSUGGEST_STRATEGY=(history completion);
            _zsh_autosuggest_start
        ' nocd zsh-users/zsh-autosuggestions

    zinit ice lucid wait'!' from'gh' atclone'./install --bin' atpull'%atclone' as'program' src'shell/completion.zsh' pick'bin/fzf'
    zinit light junegunn/fzf
    zinit ice lucid from'gh-r' as'program' pick'ripgrep*/rg'
    zinit light BurntSushi/ripgrep
    zinit ice lucid from'gh-r' as'program' pick'fd*/fd'
    zinit light sharkdp/fd
    zinit ice lucid from'gh-r' ver'nightly' as'program' pick'nvim*/bin/nvim'
    zinit light neovim/neovim
fi

if (( $+commands[gh] )); then
    eval $(gh completion -s zsh)
fi
