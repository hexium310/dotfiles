autoload -Uz add-zsh-hook

_zsh_remove_history() {
    local exit_code=$?
    local command=$(fc -ln -1 -1)
    local command_array=(${(z)command})
    local first_command=${(Q)${(z)command_array}[1]}

    if [[ -z $first_command ]]; then
        return
    fi

    while [[ ${first_command[1]} = '$' ]]; do
        first_command=${(P)${first_command:1}}
    done

    if
        (( exit_code )) &&
        [[ ${+builtins[$first_command]} -eq 0 ]] &&
        [[ ${+commands[$first_command]} -eq 0 ]] &&
        [[ ${+functions[$first_command]} -eq 0 ]] &&
        [[ ${+aliases[$first_command]} -eq 0 ]] &&
        [[ ${reswords[(r)$first_command]} != ${(Q)first_command} ]]
    then
        case $OSTYPE in
            darwin*)
                sed -i '' '$d' $HISTFILE
                ;;

            *)
                sed -i '$d' $HISTFILE
                ;;
        esac
        fc -R $HISTFILE
    fi
}

add-zsh-hook precmd _zsh_remove_history
add-zsh-hook zshexit _zsh_remove_history
