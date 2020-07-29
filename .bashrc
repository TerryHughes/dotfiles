#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -l --human-readable -v --group-directories-first --almost-all'
alias grep='grep --color=auto'
alias pacman='pacman --color auto'

go() {
	SetTitle=true
	DoNotSetTitle=%2

	Location=$1

	if [ -d ~/projects/$Location ]; then
		cd ~/projects/$Location
		return
	fi

	if [ $Location == "p" ]; then Location="projects"; fi

	if [ -d ~/$Location ]; then
		cd ~/$Location
		return
	fi

	if [ $Location == "adventure" ] || [ $Location == "adv" ]; then
		Location="Legacy/FifthElement/dev/work/projects/adventure"
		return
	fi

	if [ $Location == "handmade-hero" ] || [ $Location == "hmh" ]; then
		Location="Legacy/FifthElement/dev/Handmade\ Hero"
		return
	fi

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

alias ap='g add --patch'
alias br='g branch'
alias cia='g commit --amend --no-edit'
alias cif='g commit --fixup'
alias cim='g commit --message'
alias co='g checkout'
alias f='g fetch'
alias fpdr='f --prune --dry-run'
alias g='git'
#alias gg='g gui'
#alias k='gitk'
#alias ka='k --all'
alias l='g log --graph --oneline'
alias la='l --all'
alias lg='lazygit'
alias rb='g rebase'
alias rba='rb --abort'
alias rbc='rb --continue'
alias rbi='rb --interactive'
alias shl='g stash list'
shp() {
	g stash pop
	shl
}
alias st='g status --short --branch'

PS1='[\u@\h \W]\$ '

export PATH="$PATH:$HOME/tools"
