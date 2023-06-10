[[ -e /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path $PATH
zstyle ':completion:*' ignore-@arents parent pwd ..
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

ZSH_COMPLETION_DIR=$XDG_CACHE_HOME/zsh/completions
if ! [[ -d $ZSH_COMPLETION_DIR ]]; then
    mkdir -p $ZSH_COMPLETION_DIR
fi
fpath=($ZSH_COMPLETION_DIR $fpath)

__generate_completion() {
    setopt local_options extended_glob
    local filename=$1
    local file=$ZSH_COMPLETION_DIR/$filename
    local checks=("${(z)2}")
    shift 2

    if [[ ${#${(k)commands}:*checks} != ${#checks} ]]; then
        return
    fi

    if [[ -a $file ]] && [[ -z $file(#qN.mh+24) ]]; then
        return
    fi

    $@ > $file
}

__generate_completion '_gh' 'gh' gh completion -s zsh
__generate_completion '_rustup' 'rustup' rustup completions zsh
__generate_completion '_cargo' 'rustup cargo' rustup completions zsh cargo
__generate_completion '_docker' 'docker' docker completion zsh
