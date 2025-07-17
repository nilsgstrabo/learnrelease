#!/bin/bash




if [[ -z "$(gh label list --json name -q '.[] | select(.name=="release: tagged")')" ]]; then
  echo "empty"
fi