#!/usr/bin/env bash
set -euo pipefail

json=$(gh pr list --json title,labels,mergeCommit,state,number --state merged --label "release: pending")

jq -c '.[]' <(echo "$json") | while read i; do
    commit=$(jq .mergeCommit.oid -r <(echo "$i"))
    echo $i
    git show "$commit":charts/learnrelease/Chart.yaml | yq .version
done