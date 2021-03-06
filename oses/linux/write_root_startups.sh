#! /bin/bash

cat > /root/.bash_profile << EOB
# .bash_profile


# Get the aliases and functions
[[ -f "~/.bashrc" ]] && source ~/.bashrc

# User specific environment and startup programs

add_to_path /sbin after
add_to_path /usr/sbin after
add_to_path /usr/local/sbin after

unset USERNAME

echo Bye from ~/.bash_profile
EOB

cat > /root/.bashrc << EOB
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ \$- != *i* ]] || return


[[ -f "~/jab/environ.d/colour.sh"" ]] && source ~/jab/environ.d/colour.sh"
[[ -f "~/jab/src/bash/prompt.sh" ]] && source ~/jab/src/bash/prompt.sh red

# enable color support of ls
[[ -x /usr/bin/dircolors ]] && eval "\$(dircolors -b)"

# Alias definitions.
[[ -f "/root/.bash_aliases" ]] && source  /root/.bash_aliases

echo Bye from  ~/.bashrc
EOB

cat > /root/.bash_aliases << EOB
alias inst="/usr/bin/aptitude -y -q install"
alias reinst="/usr/bin/aptitude -y -q reinstall"
EOB

echo "# ~/.bash_logout: executed by bash(1) when login shell exits" > /root/.bash_logout
