#!/usr/bin/env bash

#set -v &&\
t=3

source tools/git.sh

echo "==Git pull and rebase=="
git_run_pull_rebase

#set +v