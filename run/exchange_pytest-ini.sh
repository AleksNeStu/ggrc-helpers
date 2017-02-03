#!/usr/bin/env bash

source tools/helper.sh

if helper_check_pytest_ini
then helper_copy_pytest_ini
else helper_copy_pytest_ini_origin
fi