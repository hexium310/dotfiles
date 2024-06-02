"com.docker.compose.project" as $compose_project |
group_by(.[$compose_project]) |
map(
  if first | has($compose_project) then
    {
      composes: [
        {
          project: first | .[$compose_project],
          count: length,
        }
      ]
    }
  else
    {
      containers: [.[].name | gsub("^/"; "")],
    }
  end
) |
.[].composes = ([.[].composes | select(.)] | flatten) |
first
