#!/usr/bin/env bash

#set -v &&\
t=3

source tools/git.sh

echo "==Git squashed last commits to one=="
git_create_squashed_commit_and_comment

#set +v