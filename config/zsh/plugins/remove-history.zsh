command_not_found_handler() {
    if [[ $(tail -1 $HISTFILE) =~ $@ ]]; then
        case $OSTYPE in
            darwin*)
                sed -i '' '$d' $HISTFILE
                ;;

            *)
                sed -i '$d' $HISTFILE
                ;;
        esac
    fi

    echo "zsh: command not found: $@"
    return 127
}
