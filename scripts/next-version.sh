#!/usr/bin/env bash
# set -euo pipefail
# next-version.sh  — SemVer bump from Conventional Commits
# Usage: next-version.sh <stable|prerelease> [suffix]

scope="${1:-stable}"          # "stable" | "prerelease"
suffix="${2:-rc}"             # prerelease suffix

# ── locate previous *stable* tag: numerics only, merged into HEAD ──────
last_stable_tag=$(git tag --merged HEAD -l 'v*.*.*' \
                 | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
                 | sort -V | tail -n1)

last_stable_tag=${last_stable_tag:-v0.0.0}

# ── locate previous prerelease tag (still allows suffix) ────────────────
last_pre_tag=$(git tag --merged HEAD -l "v[0-9]*.[0-9]*.[0-9]*-${suffix}.[0-9]*" \
               | sort -V | tail -n1 || true)

from_tag="$last_stable_tag"
[[ "$scope" == "prerelease" && -n "$last_pre_tag" ]] && from_tag="$last_pre_tag"

# ── determine bump (major/minor/patch) from commits … (unchanged) ──────
bump=patch
while IFS= read -r msg; do
  if [[ "$msg" =~ ([A-Za-z0-9\(\)]+!)|BREAKING[[:space:]]CHANGE ]]; then
    bump=major && break
  elif [[ "$bump" != "major" && "$msg" =~ ^feat ]]; then
    bump=minor
  elif [[ "$bump" == "patch" && "$msg" =~ ^fix ]]; then
    bump=patch
  fi
done < <(git log --pretty=%s "${from_tag}..HEAD")

# ── compute next SemVer (unchanged) ────────────────────────────────────
clean_base() { echo "${1#v}" | cut -d'-' -f1; }

# if [[ -n "$last_stable_tag" ]]; then
#   base="$(clean_base "$last_stable_tag")"
# else                                   # no previous tag at all
#   base="0.0.0"
# fi

base="$(clean_base "$last_stable_tag")"
base="${base:-0.0.0}"
IFS=. read -r major minor patch <<<"$base"
# major=${major:-0}
# minor=${minor:-0}
# patch=${patch:-0}

case "$bump" in
  major) major=$((10#$major + 1)); minor=0; patch=0 ;;
  minor) minor=$((10#$minor + 1)); patch=0 ;;
  patch) patch=$((10#$patch + 1)) ;;
esac
next="v${major}.${minor}.${patch}"

# ── append prerelease counter when requested (unchanged) ───────────────
if [[ "$scope" == "prerelease" ]]; then
    count=$(git tag -l "${next}-${suffix}.*" \
            | sed -E "s/^${next}-${suffix}\.//" \
            | sort -V | tail -n1)

    if [[ "$count" =~ ^[0-9]+$ ]]; then
        count=$((10#$count + 1))
    else
        count=0
    fi

    next="${next}-${suffix}.${count}"
fi

echo "$next"
