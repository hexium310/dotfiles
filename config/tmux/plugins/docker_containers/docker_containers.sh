docker_containers() {
  docker inspect --format '{
    "name": {{json .Name}} {{with (index .Config.Labels "com.docker.compose.project")}},
    "com.docker.compose.project": {{json .}} {{end}}
  }' $(docker ps --quiet) |
    jq --slurp --from-file "$XDG_CONFIG_HOME/tmux/plugins/docker_containers/docker_containers.jq"
}

compose_containers() {
  jq --raw-output '.composes | .[] | .project + "(" + (.count | tostring) + ")"'
}

containers() {
  jq --raw-output '.containers[]'
}

main() {
  local shows=""
  local list=$(docker_containers)

  while [[ $# -gt 0 ]]; do
    case $1 in
      --compose)
        shows+=$(compose_containers <<< $list)
        shows+=$'\n'
        shift
        ;;
      --container)
        shows+=$(containers <<< $list)
        shows+=$'\n'
        shift
        ;;
      *)
        shift
        ;;
    esac
  done

  echo $shows
}

main "$@"
