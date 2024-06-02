docker_containers() {
  docker ps --quiet |
    xargs docker inspect --format '{
      "name": {{json .Name}} {{with (index .Config.Labels "com.docker.compose.project")}},
      "com.docker.compose.project": {{json .}} {{end}}
    }' |
    jq --slurp --from-file "$XDG_CONFIG_HOME/tmux/plugins/docker_containers/docker_containers.jq"
}

compose_containers() {
  jq --raw-output '.composes | .[] | .project + "(" + (.count | tostring) + ")"' <<< $(docker_containers)
}

containers() {
  jq --raw-output '.containers[]' <<< $(docker_containers)
}

main() {
  local shows=""

  while [[ $# -gt 0 ]]; do
    case $1 in
      --compose)
        shows+=$(compose_containers)
        shows+=$'\n'
        shift
        ;;
      --container)
        shows+=$(containers)
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
