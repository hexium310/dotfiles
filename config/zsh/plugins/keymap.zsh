bindkey -v
bindkey -M viins -r '^B' '^C' '^D' '^F' '^K' '^N' '^O' '^P' '^Q' '^T' '^Y' '^Z'
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' vi-first-non-blank
bindkey -M viins '^E' vi-end-of-line
bindkey -M viins '^F' vi-forward-word
bindkey -M viins '^N' history-beginning-search-forward-end
bindkey -M viins '^P' history-beginning-search-backward-end
bindkey -M viins '^S' push-line
bindkey -M viins '^T' transpose-words
bindkey -M viins '^U' kill-whole-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^[[A' history-beginning-search-backward-end
bindkey -M viins '^[[B' history-beginning-search-forward-end

bindkey -M vicmd -r '^D' '=' ':'
bindkey -M vicmd '^N' history-beginning-search-forward-end
bindkey -M vicmd '^P' history-beginning-search-backward-end
bindkey -M vicmd '^T' transpose-words
bindkey -M vicmd ':w^M' vi-cmd-mode

zmodload zsh/complist
bindkey -M menuselect '^[' vi-cmd-mode
bindkey -M menuselect '^[[Z' reverse-menu-complete
