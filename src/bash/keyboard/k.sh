#! /bin/cat

# x

k () {
    local _dir="$1"; shift
    [[ -z "$*" ]] && _dir=.
    if [[ -d "$_dir" ]]; then
        (${KCD:-cd} $_dir; 
        "$@")
    fi
}

# xx

kk () {
    clear
    k "$@"
}

kl () {
    kk "$@"
    lk
}

kv () {
    (cd $1; shift
    vim -p "$@"
    gsi)
}

# xxx

kkk () {
    :  # Name reserved
}


