() {
    local file
    for file in $ZDOTDIR/{plugins,local}/*.zsh(DN); do
        source $file
    done
}

if [[ -a $XDG_DATA_HOME/zcomet/bin/zcomet.zsh ]]; then
    zstyle ':zcomet:*' home-dir $XDG_DATA_HOME/zcomet
    source $XDG_DATA_HOME/zcomet/bin/zcomet.zsh

    zcomet load b4b4r07/zsh-vimode-visual
    zcomet load --no-submodules chitoku-k/fzf-zsh-completions
    zcomet load chitoku-k/zsh-reset-title
    zcomet load chitoku-k/zsh-vcs-extended
    zcomet load chitoku-k/zsh-togglecursor
    _zsh_togglecursor_reset() {
        _zsh_togglecursor_apply_cursor 'line'
    }

    zcomet load junegunn/fzf shell completion.zsh
    (( ${+commands[fzf]} )) || ~[fzf]/install --bin

    zcomet load zsh-users/zsh-autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247,underline'
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(fzf-completion vi-cmd-mode history-beginning-search-backward-end history-beginning-search-forward-end)
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)

    zcomet load zsh-users/zsh-completions
    zcomet load zsh-users/zsh-syntax-highlighting

    zcomet compinit
fi

if (( $+commands[gh] )); then
    eval $(gh completion -s zsh)
fi
