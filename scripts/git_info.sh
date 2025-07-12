#!/bin/bash
# git_info.sh

GIT_COMMIT=$(git rev-parse HEAD)
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

cat <<EOF
{
  "commit": "$GIT_COMMIT",
  "branch": "$GIT_BRANCH"
}
EOF
