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
