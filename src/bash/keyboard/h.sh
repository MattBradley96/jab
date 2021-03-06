#! /usr/bin/env kat -n

. ~/bash/history.sh
. ~/bash/keyboard/v.sh


# _
# x

h () {
    local __doc__="tail history for half a screen"
    local _options=$(( $LINES / 2 ))
    history_tail "$@" $_options
}

# _x
# xx

alias HG=$(which hg 2>/dev/null) # With apologies, but don't really use it

h1 () {
    history_tail 2 | head -n 1
}

hd () {
    vim_diff -o "$@"
}

alias hb=big_history_grep
alias hg=history_grep
alias hh=history_head

hl () {
    h "$@" | less
}

alias ht=history_tail
alias hv=history_vim
alias vh="history_vim -[ 1"
alias vhh="history_vim -[ 2"
alias hhv="history_vim -h"


# xxx

hgt () {
    local __doc__="grep and tail history"
    hg "$@" | tail
}



# history_xxxx+

history_parse () {
    HISTTIMEFORMAT= history "$@" | sed -e "s/^ *[0-9]*  //"  | grep -v -e "^\<\(history\(_[a-z-]*\)*\|[Hh][Gghnt]\|h [0-9][0-9]*$\)\> "
}

hyp_executable  () {
    type "$@" > /dev/null 2>&1
}

history_view () {
    local __doc__="view history"
    local _viewer=
    hyp_executable "$1" && _viewer="$1"
    [[ $_viewer ]] && shift || _viewer=tail
    local _options="-n $(( $LINES - 7 ))"
    [[ $1 == -n ]] && shift
    if [[ $1 =~ ^[0-9] ]]; then
        _options="-n $1"
        shift
    fi
    history_parse "$@" | $_viewer $_options
}

history_head () {
    history_view head "$@"
}

big_history_grep () {
    local number_=32
    if [[ $1 == "-n" && $2 =~ ^[0-9]*$ ]]; then
        number_=$2
        shift 2
    fi
    grep "$@" ~/.big_eternal_history | tail -n $number_ | g "$@"
}

history_grep () {
    local __doc__="grep in history"
    [[ $1 =~ (-h|--help) ]] && ww hg && return 0
    local _back=
    [[ $1 =~ -B[0-9] ]] && _back=$1 && shift
    local _sought="$@"
    history_parse | sed -es':^ *::' -e 's: *$::' | grep --color $_back "${_sought/ /.}"
}

history_tail () {
    history_view tail "$@"
}

history_vim () {
    local __doc__="edit history"
    local command_= tmp_=~/tmp/history.tmp
    [[ $1 == -[ ]] && shift && command_=$(history -p !-$1) && shift
    [[ $1 == -h ]] && shift && command_=h
    [[ $command_ ]] || command_=history_parse
    $command_ "$@" > $tmp_
    local vim_suffix_=+
    if [[ -n $* ]]; then
        [[ "$@" =~ ^+ ]] && vim_suffix_="$@" || vim_suffix_=+/"$@"
    fi
    vim $tmp_ $vim_suffix_
}

hgf () {
    local sought_="$1"; shift
    local message_="$1"; shift
    (history | head -n 31 | grep --color $sought_ ) && show_fail "$message_"
}

close_kaufman () {
    hgf jeffkaufman "Close window"
}

hgg () {
    close_kaufman "$@"
}
