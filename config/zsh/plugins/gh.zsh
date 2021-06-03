autoload -Uz colors
colors

gh-vulns() {
    local owner=${1-hexium310}
    local endCursor vulnerability
    local repositories=""

    # while
    #     result=$(gh api graphql \
    #         --jq '.data | select(.repositoryOwner != null).repositoryOwner.repositories | { pageInfo: .pageInfo, repositories: [(.edges[] | select(.node.vulnerabilityAlerts.nodes | length > 0)).node | { repository: .name, url: .url, vulnerabilityAlerts: .vulnerabilityAlerts.nodes[] }] | group_by(.vulnerabilityAlerts.securityVulnerability.advisory.ghsaId) }' \
    #         -F owner=$owner -F cursor=${endCursor:-null} -f query='query ($owner: String!, $cursor: String) {
    #             repositoryOwner(login: $owner) {
    #                 repositories(first: 100, after: $cursor) {
    #                     pageInfo {
    #                         startCursor
    #                         endCursor
    #                         hasNextPage
    #                         hasPreviousPage
    #                     }
    #                     edges {
    #                         node {
    #                             name
    #                             url
    #                             vulnerabilityAlerts(first: 100) {
    #                                 nodes {
    #                                     vulnerableRequirements
    #                                     vulnerableManifestPath
    #                                     securityVulnerability {
    #                                         advisory {
    #                                             ghsaId
    #                                             publishedAt
    #                                             notificationsPermalink
    #                                             summary
    #                                         }
    #                                         severity
    #                                         vulnerableVersionRange
    #                                         firstPatchedVersion {
    #                                             identifier
    #                                         }
    #                                         package {
    #                                             name
    #                                         }
    #                                     }
    #                                 }
    #                             }
    #                         }
    #                     }
    #                 }
    #             }
    #         }')
    #
    #     if [[ -z $result ]]; then
    #         return
    #     fi
    #
    #     repositories+=$(jq '{ repositories: .repositories[] | values }' <<< $result)
    #
    #     endCursor=$(jq -r '.pageInfo.endCursor | strings' <<< $result)
    #     $(jq -r '.pageInfo.hasNextPage' <<< $result)
    # do :; done

    # repositories=$(jq --slurp 'reduce .[] as $item ([]; . + $item.repositories) | [group_by(.vulnerabilityAlerts.securityVulnerability.advisory.ghsaId)[] | flatten]' <<< $repositories)
    # vulnerabilities=($(jq 'walk(if type == "object" then to_entries else . end) | walk(if type == "object" then if .key == "repository" then "", .value else .value end else . end) | flatten | .[]' <<< $repositories))
    # vulnerabilities=(${(ps:"":)vulnerabilities})

    local current_ghsa_id
    local keys=(
    repository
    url
    ghsa_id
    notifications_permalink
    published_at
    summary
    first_patched_version
    package_name
    severity
    vulnerable_version_range
    vulnerable_manifest_path
    vulnerable_requirements
)
local -A severity_colors=(CRITICAL red HIGH orange MODERATE yellow LOW blue)
fg[orange]=$(printf "\x1b[38;2;255;165;0m")
for vulnerability in $vulnerabilities; do
    local tmp=(${(Q)${(z)vulnerability}})
    local -A info=(${keys:^tmp})

    if [[ ${info[ghsa_id]} != $current_ghsa_id ]]; then
        if [[ -n $current_ghsa_id ]]; then
            echo
        fi
        current_ghsa_id=${info[ghsa_id]}
        echo package name: ${fg_bold[green]}${info[package_name]}$reset_color
        echo "Upgrade to version \e[4m${fg_bold[default]}${info[first_patched_version]}${fg_no_bold[default]} or later$reset_color"
        echo details:
        echo "  ${info[ghsa_id]} ${fg[${severity_colors[${info[severity]}]}]}${info[severity]}$reset_color"
        echo "  ${fg[blue]}\e[4m${info[notifications_permalink]}$reset_color"
        echo -n "  published at \e[4m"
        date -j -f '%Y-%m-%dT%H:%M:%SZ' "${info[published_at]}" +"%d/%m/%Y %H:%M:%S$reset_color"
        echo "  Vulnerable versions: ${info[vulnerable_version_range]}"
        echo "  \e[3mSummery"
        echo "    ${info[summary]}$reset_color"
    fi
    echo ${info[repository]}
    echo ${info[url]}
    echo ${info[vulnerable_manifest_path]}
    echo ${info[vulnerable_requirements]}
    echo
done
unset fg[orange]

    # aaa=$repositories

    # echo $result | jq .
}
