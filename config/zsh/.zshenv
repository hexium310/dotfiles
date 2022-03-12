export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export ATOM_HOME="$XDG_CONFIG_HOME/atom"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export DENO_DIR="$XDG_CACHE_HOME/deno"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export REVOLVER_DIR="$XDG_CACHE_HOME/revolver"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
export GOPATH=$XDG_CACHE_HOME/go
typeset -U path=(
    '/usr/local/sbin'
    "$CARGO_HOME/bin"
    "$GEM_HOME/bin"
    "$COMPOSER_HOME/bin"
    "${path[@]}"
)


if [[ -o login ]]; then
    __link_bin_directory_for_homebrew_keg_only() {
        local bin
        local bin_dir=$1
        local bins=(${$(echo $bin_dir/*(N)):t})
        for bin in $bins; do
            if ! [[ -h /usr/local/bin/$bin ]]; then
                lndir $bin_dir /usr/local/bin/
                break
            fi
        done
    }

    __link_bin_directory_for_homebrew_keg_only /usr/local/opt/ruby/bin
    __link_bin_directory_for_homebrew_keg_only /usr/local/opt/curl/bin

    unfunction __link_bin_directory_for_homebrew_keg_only
fi
