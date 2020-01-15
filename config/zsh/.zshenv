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
export PATH="/usr/local/sbin:$PATH"
export PATH="$CARGO_HOME/bin:$PATH"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
export PATH="$HOME/Repositories/hexium310/git-issue/target/debug:$PATH"
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZPLG_HOME=$XDG_CACHE_HOME/zplugin

declare -A ZPLGM
ZPLGM[HOME_DIR]=$XDG_CACHE_HOME/zplugin
ZPLGM[BIN_DIR]=$ZPLGM[HOME_DIR]/bin
ZPLGM[PLUGINS_DIR]=$ZPLGM[HOME_DIR]/plugins
ZPLGM[COMPLETIONS_DIR]=$ZPLGM[HOME_DIR]/completions
ZPLGM[SNIPPETS_DIR]=$ZPLGM[HOME_DIR]/snippets
export ZPLGM
