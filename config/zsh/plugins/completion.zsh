[[ -e /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path $PATH
zstyle ':completion:*' ignore-@arents parent pwd ..
zstyle ':completion:*' matcher-lsit 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

ZSH_COMPLETION_DIR=$XDG_CACHE_HOME/zsh/completion
fpath=($ZSH_COMPLETION_DIR $fpath)
if ! [[ -d $ZSH_COMPLETION_DIR ]]; then
    mkdir -p $ZSH_COMPLETION_DIR
fi

if (( ${+commands[gh]} )); then
    gh completion -s zsh > $ZSH_COMPLETION_DIR/_gh
fi

if (( ${+commands[rustup]} )); then
    rustup completions zsh > $ZSH_COMPLETION_DIR/_rustup
fi

if (( ${+commands[rustup]} )) && (( ${+commands[cargo]} )); then
    rustup completions zsh cargo > $ZSH_COMPLETION_DIR/_cargo
fi
