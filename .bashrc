#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman --color auto'

go() {
	SetTitle=true
	DoNotSetTitle=%2

	Location=$1

	echo Unknown location \'$Location\'
}
pgo() {
	pushd .
	go $1 true
}
mcd() {
	mkdir $1
	cd $1
}
alias fstr='grep -inr'
fs() {
	fstr $1 --include="*.sh" --include="*.h" --include="*.c"
}
alias v='vim'

alias g='git'
