#!/usr/bin/env bash

git checkout -b AlexNo-ggrc-437-rm-request release/0.9.7-Quince
git pull https://github.com/AlexNo/ggrc-core.git ggrc-437-rm-request


git checkout -b GGRC-624 develop
git pull https://github.com/plamut/ggrc-core.git unify-date-formats-develop


git checkout -b GGRC-103 develop
git pull https://github.com/AlexNo/ggrc-core.git ggrc-103