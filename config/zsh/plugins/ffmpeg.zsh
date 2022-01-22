ffmpeg-twitter() {
    local input=$1
    shift 1

    local input_data=$(ffprobe -loglevel quiet -show_streams -print_format json -i "$input" | jq .)
    local original_duration=$(jq --raw-output '.streams[] | select(.codec_type == "video").duration' <<< "$input_data")
    # Add 0.05 to round up for keeping video duration less than 140s
    local speed_rate=$(printf '%.1f' $(( original_duration > 140 ? original_duration / 140 + 0.05 : 1 )))

    if (( $speed_rate > 2 )) &&
        echo -n "Original video duration is $speed_rate times more longer than 140s. Do you want to speed up? (y/N)" &&
        ! read -q; then
        return
    fi

    ffmpeg \
        -i "$input" \
        -codec:v libx264 \
        -codec:a aac \
        -filter_complex "$(cat << EOF
            setpts=PTS/$speed_rate,
            scale='if(gt(iw, ih), min(1920, iw), -1)':'if(gt(iw, ih), -1, min(1920, ih))',
            fps=fps='min(40, round(source_fps))
EOF
            )" \
        -filter:a atempo="$speed_rate" \
        -maxrate 25M \
        "$@" &&
        echo ${${(M)@#*.mp4}:P}
}
