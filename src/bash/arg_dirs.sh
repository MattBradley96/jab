#! /bin/bash



__reuse_path () {
    [[ -n $path && -d "$path" ]] && return 0
    _shift_path "$@"
    return $?
}

_shift_path () {
    local _path=$(pwd) _arg=
    [[ -z "$*" ]] && return 0
    for _arg in "$@"
    do
        if [[ -f "$_arg" || -d "$_arg" ]]; then
            _path=$(_python_realpath $_arg)
            return 0
        fi
    done
    [[ $_path ]]
}

_python_realpath () {
    python -c"import os; print(os.path.realpath('""$@""'))"
}

__reuse_dir () {
    [[ -n $dir && -d "$dir" ]] && return 0
    _first_arg_dir "$@"
    return $?
}

__all_dir_args () {
    dir=
    dirr=   # bash is using "dirs"
    [[ -z "$*" ]] && return 1
    for _arg in "$@"; do
        [[ -d "$_arg" ]] || continue
        _arg_dir=$(_python_realpath "$_arg")
        [[ -z "$dir" ]] && dir="$_arg_dir"
        [[ -z "$dirr" ]] && dirr="$_arg_dir" || dirr="$dirr:$_arg_dir"
    done
    [[ -z "$dirr" ]] && return 1
    [[ $dir ]]
}

__any_dir_arg () {
    dir=
    [[ -z "$*" ]] && return 1
    for _arg in "$@"; do
        [[ -d "$_arg" ]] || continue
        dir=$(_python_realpath "$_arg")
        return 0
    done
    [[ $dir ]]
}

_first_arg_dir () {
    dir=$(show_arg_dir "$@")
    [[ $dir ]]
}

__echo_shift_dir () {
    shift_dir "$@" || return 1
    echo $dir
    [[ $dir ]]
}

show_arg_dir () {
    [[ "$*" ]] || return 1
    [[ -d "$1" ]] || return 1
    _python_realpath "$1"
    return 0
}

show_arg_dir_or_here () {
    local _result=$(show_arg_dir "$@")
    [[ $_result ]] || _result=$(readlink -f .)
    echo $_result
}

shift_dir () {
    true
    dir=$(show_arg_dir_or_here "$@")
    export dir
    true
    [[ -d $dir ]]
}

