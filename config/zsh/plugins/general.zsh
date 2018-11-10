autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

KEYTIMEOUT=1

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt magic_equal_subst
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
setopt extended_history
setopt auto_resume
setopt ignore_eof
setopt no_flow_control
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
setopt globdots
setopt extended_glob

unsetopt caseglob

HISTFILE=~/.config/zsh/.zsh_history
SAVEHIST=100000
HISTSIZE=100000
