#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -l --human-readable -v --group-directories-first --almost-all'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
