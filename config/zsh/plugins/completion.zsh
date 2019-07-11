[[ -e /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path $PATH
zstyle ':completion:*' ignore-@arents parent pwd ..
zstyle ':completion:*' matcher-lsit 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
