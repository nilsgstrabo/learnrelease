#!/usr/bin/env bash


# json=$(gh pr list --json title,labels,mergeCommit,state,number --state merged --label "release: pending")

# jq -c '.[]' <(echo "$json") | while read i; do
#     commit=$(jq .mergeCommit.oid -r <(echo "$i"))
#     echo $i
#     git show "$commit":charts/learnrelease/Chart.yaml | yq .version
# done

set -Eeuo pipefail

next_prerelease_tag=v$(cli next --pre-release-tag rc --pre-release-counter)
next_stable_tag=v$(cli next)
latest_tag=v$(cli latest --include-pre-releases)

next_stable_tag_greater_than_latest="false"
if [ "$(cli compare $next_stable_tag $latest_tag 2>&1)" = ">" ]; then
    next_stable_tag_greater_than_latest="true"
fi

next_prerelease_tag_greater_than_latest="false"
if [ "$(cli compare $next_prerelease_tag $latest_tag 2>&1)" = ">" ]; then
    next_prerelease_tag_greater_than_latest="true"
fi

echo "next tag greater: $next_stable_tag_greater_than_latest"
echo "next prerelease greater: $next_prerelease_tag_greater_than_latest"

# pr_number=$1

# pr_info=$(gh pr view $pr_number --json title,labels,mergeCommit,state,number,body | jq 'select(.state=="MERGED" and (.labels[] | .name=="release: pending"))')
# [[ -z "$pr_info" ]] && { echo "Pull request $pr_number has invalid release state"; exit 1; }

# commit=$(echo $pr_info | jq -r .mergeCommit.oid)
# version=$(git show "$commit":charts/learnrelease/Chart.yaml | yq .version)
# version=${version#v}
# tag=v${version}
# release_body=$(echo $pr_info | jq -r .body)
# is_prerelease="false"
# if [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+- ]]; then
#     is_prerelease="true"
# fi


# echo $pr_info | jq .body

# echo $commit
# echo $version
# echo $tag
# echo "$release_body"
# # echo "release_body="$release_body""



# gh release create $tag --notes "$release_body" --target $commit --title "$tag" --prerelease=$is_prerelease
# # gh pr edit $1 --remove-label "release: pending" --add-label "release: tagged"
# # Docker build + push (hvilke tags)
