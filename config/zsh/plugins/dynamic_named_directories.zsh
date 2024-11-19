_named_directoires() {
    emulate -L zsh
    setopt extended_glob

    local -a directories
    local expl
    typeset -ga reply

    if [[ $1 == 'n' ]]; then
        local -a match mbegin mend
        [[ $2 != r:(#b)(?*) ]] && return 1

        directories=($HOME/Repositories/*/${match[1]}(N/))

        (( ${#directories} != 1 )) && return 1

        reply=(${directories[1]})
        return 0
    elif [[ $1 == 'd' ]]; then
        directories=($HOME/Repositories/*/${2:t}(N/))

        (( ${#directories} != 1 )) || [[ "${directories[0]}" != "$PWD" ]] && return 1

        reply=(${2:t} ${#2})
        return 0
    elif [[ $1 == 'c' ]]; then
        directories=($HOME/Repositories/*/*(N/:t))
        directories=(r:${^directories})
        _tags named-directories
        _tags && _requested named-directories expl 'dynamic named directories' &&
            compadd $expl -S\] -- $directories
        return 1
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook zsh_directory_name _named_directoires
