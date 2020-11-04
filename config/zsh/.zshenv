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
export ZPLG_HOME=$XDG_CACHE_HOME/zinit
export REVOLVER_DIR="$XDG_CACHE_HOME/revolver"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
export GOPATH=$XDG_CACHE_HOME/go
(( $+commands[nvim] )) && export MANPAGER='nvim +Man!'

declare -A ZINIT
ZINIT[HOME_DIR]=$XDG_CACHE_HOME/zinit
ZINIT[BIN_DIR]=$ZINIT[HOME_DIR]/bin
ZINIT[PLUGINS_DIR]=$ZINIT[HOME_DIR]/plugins
ZINIT[COMPLETIONS_DIR]=$ZINIT[HOME_DIR]/completions
ZINIT[SNIPPETS_DIR]=$ZINIT[HOME_DIR]/snippets
export ZINIT
