export EDITOR="nvim"
export ZSHRC="$ZDOTDIR/.zshrc"
export FZF_DEFAULT_COMMAND='fd --hidden --type=file --color=always --ignore-file=$XDG_CONFIG_HOME/fdignore'
export FZF_DEFAULT_OPTS='--height=50% --border --bind="ctrl-f:page-down" --bind="ctrl-b:page-up"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS\
' --color=fg:#cccccc,bg:#2d2d2d,hl:#f99157'\
' --color=fg+:#d6d6d6,bg+:#393939,hl+:#ffcc66'\
' --color=info:#99cc99,prompt:#f2777a,pointer:#cc99cc'\
' --color=marker:#99cc99,spinner:#cccccc,header:#999999'
