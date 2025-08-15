#!/bin/bash


# 2.4.1-rc.1 # x-patch-semver

if [[ -z "$(gh label list --json name -q '.[] | select(.name=="release: tagged")')" ]]; then
  echo "empty"
fi