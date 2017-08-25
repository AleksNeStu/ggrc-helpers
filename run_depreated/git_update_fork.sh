#!/usr/bin/env bash
#set -v &&\
t=3
source tools/git.sh


echo "Git update the fork of GGRC"
git_update_fork
#set +v