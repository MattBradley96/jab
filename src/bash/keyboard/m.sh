#! /bin/cat


# _
# x
# _x
# xx

alias m=echo

mvim () {
    local _mvim=/Applications/MacVim.app/Contents/bin/mvim 
    ([[ "$@" ]] && $_mvim --remote-tab "$@" || $_mvim --remote) > ~/log/mv.log 2> ~/log/mv.err
}

