#! /bin/bash

_expected=$JAB/environ.d/jab.sh; _actual="No $(basename $_expected)."; [[ -f "$_expected" ]] && _actual=$_expected;. $_actual

HOME_SSH=~/.ssh
JAB_SSH=$JAB/etc/ssh
HOME_ID=$HOME_SSH/id_rsa

authorize_jab () {
    KNOWN_KEYS=$HOME_SSH/authorized_keys
    [[ -f "$HOME_ID" ]] || ssh-keygen -q -t rsa -N "" -f $LOCAL_STEM
    chmod 600 $KNOWN_KEYS
    [[ -f "$KNOWN_KEYS" ]] && cat $JAB_PUB_ID >> $KNOWN_KEYS || cat $JAB_PUB_ID > $KNOWN_KEYS
}

change_modes () {
    sudo chmod 400 -R $JAB_SSH $HOME_SSH
    chmod u+X $HOME_SSH $JAB_SSH

    chmod 400 $JAB_ID
    chmod 444 $JAB_PUB_ID

    chmod 400 $HOME_ID
    chmod 444 $HOME_ID.pub
}

change_modes
authorize_jab
