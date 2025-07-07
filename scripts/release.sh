#!/usr/bin/env bash
set -Eeuo pipefail

# json=$(gh pr list --json title,labels,mergeCommit,state,number --state merged --label "release: pending")

# jq -c '.[]' <(echo "$json") | while read i; do
#     commit=$(jq .mergeCommit.oid -r <(echo "$i"))
#     echo $i
#     git show "$commit":charts/learnrelease/Chart.yaml | yq .version
# done

pr_info=$(gh pr view $1 --json title,labels,mergeCommit,state,number,body | jq 'select(.state=="MERGED" and (.labels[] | .name=="release: pending"))')

[[ -z "$pr_info" ]] && { echo "Pull request ${1} has invalid release state"; exit 1; }

echo $pr_info | jq .

commit=$(echo $pr_info | jq -r .mergeCommit.oid)
version=$(git show "$commit":charts/learnrelease/Chart.yaml | yq .version)
version=${version#v}
tag=v${version}
release_body=$(echo $pr_info | jq -r .body)

echo $commit
echo $version
echo $tag
echo $release_body

gh release create $tag --notes "$release_body" --target $commit --title "$tag"
gh pr edit $1 --remove-label "release: pending" --add-label "release: tagged"
# Docker build + push (hvilke tags)
