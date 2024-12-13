export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export DENO_DIR="$XDG_CACHE_HOME/deno"
export DENO_INSTALL_ROOT="$XDG_DATA_HOME/deno"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GOPATH=$XDG_CACHE_HOME/go
export KREW_ROOT=$XDG_DATA_HOME/krew
export KUBECACHEDIR=$XDG_CACHE_HOME/kube
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export REVOLVER_DIR="$XDG_CACHE_HOME/revolver"
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WASI_SDK_PATH="/opt/wasi-sdk"
export XWIN_CACHE_DIR="$XDG_CACHE_HOME/xwin"
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

export LANG=en_US.UTF-8
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

typeset -U path=(
    '/usr/local/sbin'
    "$CARGO_HOME/bin"
    "$DENO_INSTALL_ROOT/bin"
    "$GEM_HOME/bin"
    "$COMPOSER_HOME/bin"
    "${KREW_ROOT}/bin"
    "${path[@]}"
    "$GOPATH/bin"
)
