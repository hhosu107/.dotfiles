#! WARNING
#!
#! I don't really use this configuration as it is. I instead
#! copy/paste the part of it when I have to access the legacy
#! system. You'd be better not to use this file as it is either.


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Backspace
stty erase ^H

# Disable ^S and ^Q
stty stop ''
stty start ''
stty -ixon
stty -ixoff

PS1='\u@\h:\w\$ '
export LANG=ko_KR.UTF-8

# Mini ag
function ag {
  if [[ -z "$1" ]]; then
    grep --help
  else
    grep --line-number --recursive "$1" .
  fi
}

# User specific aliases and functions
alias l="ls -alh --color=yes"
alias ll="ls -lh --color=yes"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
