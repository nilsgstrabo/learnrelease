#!/bin/bash


# 0.0.0 # x-patch-semver

if [[ -z "$(gh label list --json name -q '.[] | select(.name=="release: tagged")')" ]]; then
  echo "empty"
fi