command_not_found_handler() {
    case $OSTYPE in
        darwin*)
            sed -i '' '$d' $HISTFILE
            ;;

        *)
            sed -i '$d' $HISTFILE
            ;;
    esac

    echo "zsh: command not found: $@"
}
