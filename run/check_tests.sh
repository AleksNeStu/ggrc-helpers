#!/usr/bin/env bash

dir_pr="ggrc-core"
dir_run="run"

echo "==Run selenium tests in docker=="
cd ./../$dir_pr/
bin/jenkins/run_selenium
