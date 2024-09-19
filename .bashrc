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

function dir_stack() {
	Count=`echo $(($(dirs -v | wc --lines) - 1))`
	if [ "$Count" -gt "0" ]; then
		printf " "
		printf "+%.0s" $(eval "echo {1.."$(($Count))"}")
	fi
}
function git_prompt() {
	TopLevel=`git --no-optional-locks rev-parse --show-toplevel 2>/dev/null`
	if [ "$TopLevel" == "" ]; then return; fi
	GitDirectory="$TopLevel/.git"

	if [ -f "$GitDirectory" ]; then
		Worktree=`cat .git`
		GitDirectory=${Worktree:8}
	fi

	Status=$(git --no-optional-locks status --porcelain=2 --branch --show-stash)
	CommitHash=""
	for Token in `echo "$Status" | awk --field-separator=' branch.oid ' '{print $2}'`
	do
		if [ "$Token" != "" ]; then
			if [ "$Token" == "(initial)" ]; then
				CommitHash=$Token
			else
				CommitHash=${Token:0:7}
			fi
			break
		fi
	done
	Head=""
	for Token in `echo "$Status" | awk --field-separator=' branch.head ' '{print $2}'`
	do
		if [ "$Token" != "" ]; then
			Head=$Token
			break
		fi
	done
	Upstream=""
	for Token in `echo "$Status" | awk --field-separator=' branch.upstream ' '{print $2}'`
	do
		if [ "$Token" != "" ]; then
			Upstream=$Token
			break
		fi
	done
	AheadCount=""
	BehindCount=""
	for Token in `echo "$Status" | awk --field-separator=' branch.ab ' '{print $2}'`
	do
		if [ "$Token" != "" ]; then
			if [ "$AheadCount" == "" ]; then
				AheadCount=${Token:1}
			else
				BehindCount=${Token:1}
				break
			fi
		fi
	done
	if [ "$AheadCount"  == "" ]; then AheadCount="0";  fi
	if [ "$BehindCount" == "" ]; then BehindCount="0"; fi
	Stash=""
	for Token in `echo "$Status" | awk --field-separator=' stash ' '{print $2}'`
	do
		if [ "$Token" != "" ]; then
			Stash=$Token
			break
		fi
	done

	MCountX="0"
	MCountY="0"
	RCountX="0"
	RCountY="0"
	DCountX="0"
	DCountY="0"
	ACountX="0"
	ACountY="0"
	UCountX="0"
	UCountY="0"
	TCountX="0"
	TCountY="0"
	CCountX="0"
	CCountY="0"
	qCount="0"
	eCount="0"
	TrackNextXY="false"
	TrackNextq="false"
	TrackNexte="false"
	for Token in `echo "$Status"`
	do
		if [ "$TrackNextXY" == "true" ]; then
			if [ "${Token:0:1}" == "M" ]; then let ++MCountX; fi
			if [ "${Token:1:1}" == "M" ]; then let ++MCountY; fi
			if [ "${Token:0:1}" == "R" ]; then let ++RCountX; fi
			if [ "${Token:1:1}" == "R" ]; then let ++RCountY; fi
			if [ "${Token:0:1}" == "D" ]; then let ++DCountX; fi
			if [ "${Token:1:1}" == "D" ]; then let ++DCountY; fi
			if [ "${Token:0:1}" == "A" ]; then let ++ACountX; fi
			if [ "${Token:1:1}" == "A" ]; then let ++ACountY; fi
			if [ "${Token:0:1}" == "U" ]; then let ++UCountX; fi
			if [ "${Token:1:1}" == "U" ]; then let ++UCountY; fi
			if [ "${Token:0:1}" == "T" ]; then let ++TCountX; fi
			if [ "${Token:1:1}" == "T" ]; then let ++TCountY; fi
			if [ "${Token:0:1}" == "C" ]; then let ++CCountX; fi
			if [ "${Token:1:1}" == "C" ]; then let ++CCountY; fi
		fi
		if [ "$TrackNextq"  == "true" ]; then let ++qCount; fi
		if [ "$TrackNexte"  == "true" ]; then let ++eCount; fi

		TrackNextXY="false"
		TrackNextq="false"
		TrackNexte="false"
		if [ "$Token" == "1" ] || [ "$Token" == "2" ] || [ "$Token" == "u" ]; then
			TrackNextXY="true"
		fi

		if [ "$Token" == "?" ]; then
			TrackNextq="true"
		fi

		if [ "$Token" == "!" ]; then
			TrackNexte="true"
		fi
	done

	printf "\n"
	printf "\e[33m$CommitHash\e[m "
	if [ "$Head" == "(detached)" ]; then
		DetachedColor="\e[31m"
		printf "$DetachedColor"
		BranchName=""
		Onto=""
		if [ -d "$GitDirectory/rebase-apply" ]; then
			if ! [ -f "$GitDirectory/rebase-apply/applying" ]; then
				HeadName=`cat $GitDirectory/rebase-apply/head-name`
				BranchName="${HeadName:11}"
				Onto=`cat $GitDirectory/rebase-apply/onto`

				printf "applying "
			fi
		else
			HeadName=`cat $GitDirectory/rebase-merge/head-name`
			BranchName="${HeadName:11}"
			Onto=`cat $GitDirectory/rebase-merge/onto`

			if [ -f "$GitDirectory/rebase-merge/interactive" ]; then
				printf "interactive "
			fi
			printf "rebasing "
		fi
		DetachedHighlightColor="\e[1;m"
		printf "'$DetachedHighlightColor$BranchName\e[m$DetachedColor' onto '$DetachedHighlightColor${Onto:0:7}\e[m$DetachedColor'\e[m"
	else
		printf "\e[32m$Head\e[m"
	fi
	if [ "$Upstream" != "" ]; then
		printf "...\e[31m$Upstream\e[m"
	fi
	Glyphs="false"
	DistancePrefix=" ["
	DistanceSuffix="]"
	if [ "$AheadCount" -gt "0" ] || [ "$BehindCount" -gt "0" ]; then
		printf "$DistancePrefix"
		if [ "$Glyphs" == "true" ]; then
			if [ "$AheadCount"  -gt "0" ]; then printf "↑\e[32m$AheadCount\e[m";   fi
			if [ "$BehindCount" -gt "0" ]; then printf "↓\e[31m$BehindCount\e[m"; fi
		else
			if [ "$AheadCount"  -gt "0" ]; then printf "ahead \e[32m$AheadCount\e[m";   fi
			if [ "$AheadCount"  -gt "0" ] && [ "$BehindCount" -gt "0" ]; then printf ", "; fi
			if [ "$BehindCount" -gt "0" ]; then printf "behind \e[31m$BehindCount\e[m"; fi
		fi
		printf "$DistanceSuffix"
	elif [ "$Upstream" != "" ]; then
		if [ "$Glyphs" == "true" ]; then
			printf "$DistancePrefix\e[32m✓\e[m$DistanceSuffix"
		fi
	else
		if [ "$Glyphs" == "true" ]; then
			printf "$DistancePrefix\e[31m✗\e[m$DistanceSuffix"
		fi
	fi
	if [ "$Stash" != "" ]; then
		printf " \e[1;41mstash@{$Stash}\e[m"
	fi

	if [ "$MCountX" -gt "0" ] || [ "$MCountY" -gt "0" ]; then
		printf " M:"
		if [ "$MCountX" -gt "0" ]; then printf "\e[32m$MCountX\e[m"; fi
		if [ "$MCountX" -gt "0" ] && [ "$MCountY" -gt "0" ]; then printf ","; fi
		if [ "$MCountY" -gt "0" ]; then printf "\e[31m$MCountY\e[m"; fi
	fi
	if [ "$RCountX" -gt "0" ] || [ "$RCountY" -gt "0" ]; then
		printf " R:"
		if [ "$RCountX" -gt "0" ]; then printf "\e[32m$RCountX\e[m"; fi
		if [ "$RCountX" -gt "0" ] && [ "$RCountY" -gt "0" ]; then printf ","; fi
		if [ "$RCountY" -gt "0" ]; then printf "\e[31m$RCountY\e[m"; fi
	fi
	if [ "$DCountX" -gt "0" ] || [ "$DCountY" -gt "0" ]; then
		printf " D:"
		if [ "$DCountX" -gt "0" ]; then printf "\e[32m$DCountX\e[m"; fi
		if [ "$DCountX" -gt "0" ] && [ "$DCountY" -gt "0" ]; then printf ","; fi
		if [ "$DCountY" -gt "0" ]; then printf "\e[31m$DCountY\e[m"; fi
	fi
	if [ "$ACountX" -gt "0" ] || [ "$ACountY" -gt "0" ]; then
		printf " A:"
		if [ "$ACountX" -gt "0" ]; then printf "\e[32m$ACountX\e[m"; fi
		if [ "$ACountX" -gt "0" ] && [ "$ACountY" -gt "0" ]; then printf ","; fi
		if [ "$ACountY" -gt "0" ]; then printf "\e[31m$ACountY\e[m"; fi
	fi
	if [ "$UCountX" -gt "0" ] || [ "$UCountY" -gt "0" ]; then
		printf " U:"
		if [ "$UCountX" -gt "0" ]; then printf "\e[32m$UCountX\e[m"; fi
		if [ "$UCountX" -gt "0" ] && [ "$UCountY" -gt "0" ]; then printf ","; fi
		if [ "$UCountY" -gt "0" ]; then printf "\e[31m$UCountY\e[m"; fi
	fi
	if [ "$TCountX" -gt "0" ] || [ "$TCountY" -gt "0" ]; then
		printf " T:"
		if [ "$TCountX" -gt "0" ]; then printf "\e[32m$TCountX\e[m"; fi
		if [ "$TCountX" -gt "0" ] && [ "$TCountY" -gt "0" ]; then printf ","; fi
		if [ "$TCountY" -gt "0" ]; then printf "\e[31m$TCountY\e[m"; fi
	fi
	if [ "$CCountX" -gt "0" ] || [ "$CCountY" -gt "0" ]; then
		printf " C:"
		if [ "$CCountX" -gt "0" ]; then printf "\e[32m$CCountX\e[m"; fi
		if [ "$CCountX" -gt "0" ] && [ "$CCountY" -gt "0" ]; then printf ","; fi
		if [ "$CCountY" -gt "0" ]; then printf "\e[31m$CCountY\e[m"; fi
	fi
	if [ "$qCount" -gt "0" ]; then printf " ?:\e[31m$qCount\e[m"; fi
	if [ "$eCount" -gt "0" ]; then printf " !:$eCount"; fi
}
PS1='[\u@\h \j \w$(dir_stack)]$(git_prompt)\n\$ '

export PATH="$PATH:$HOME/tools"
