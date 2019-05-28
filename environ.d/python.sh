#! /bin/bash

. ~/bash/welcome.sh

Welcome_to $BASH_SOURCE

. ~/bash/python.sh

PYTHON=${PYTHON:-$(pypath which python 2> ~/bash/fd/2)}
    
export PIP_REQUIRE_VIRTUALENV=false
export PIP_RESPECT_VIRTUALENV=true

_has_ext () {
    [[ -d $2 ]] && [[ -n $(ls ${2:-.}/*.$1 2>/dev/null | grep -v -e fred -e log  | head -n 1) ]]
}

_has_py () {
    _has_ext py "$@"
}

_try="~/jab/src/python/testing/try.py"
[[ -f "$_try" ]] || _try=no_file_try_py
export TRY=$_try

. ~/jab/environ.d/jab.sh
. ~/jab/src/bash/add_to_a_path.sh

add_to_a_path PYTHONPATH ~/jab/src/python/site
add_to_a_path PYTHON_SOURCE_PATH ~/jab/src/python
add_to_a_path PYTHON_SOURCE_PATH ~/src/python
[[ -f ~/jab/src/python/pythonrc.py ]] && export PYTHONSTARTUP=~/jab/src/python/pythonrc.py

_upgrade_package () {
    (pip2 install --upgrade --retries=1 "$@" > ~/bash/fd/1 2> ~/bash/fd/2)
    (pip3 install --upgrade --retries=1 "$@" > ~/bash/fd/1 2> ~/bash/fd/2)
}

upgrades () {
    _upgrade_package pip
    _upgrade_package pysyte
}

upgrades

Bye_from $BASH_SOURCE
