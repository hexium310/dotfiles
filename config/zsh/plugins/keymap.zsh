bindkey -v
bindkey -M viins -r '^B' '^C' '^D' '^F' '^G' '^K' '^N' '^O' '^P' '^Q' '^T' '^Y' '^Z'
bindkey -M viins '^A' vi-first-non-blank
bindkey -M viins '^E' vi-end-of-line
bindkey -M viins '^[[A' history-beginning-search-backward-end
bindkey -M viins '^[[B' history-beginning-search-forward-end
bindkey -M viins '^S' push-line
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^T' transpose-words

bindkey -M vicmd -r '^D' '=' ':'
bindkey -M vicmd '^T' transpose-words
