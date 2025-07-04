#!/usr/bin/env bash
set -euo pipefail

# json=$(gh pr list --json title,labels,mergeCommit,state,number --state merged --label "release: pending")

# jq -c '.[]' <(echo "$json") | while read i; do
#     commit=$(jq .mergeCommit.oid -r <(echo "$i"))
#     echo $i
#     git show "$commit":charts/learnrelease/Chart.yaml | yq .version
# done

pr_info=$(gh pr view $1 --json title,labels,mergeCommit,state,number | jq 'select(.state=="MERGED" and (.labels[] | .name=="release: pending"))')

[[ -z "$pr_info" ]] && { echo "Pull request ${1} does not exist or has invalid state"; exit 1; }

echo $pr_info
