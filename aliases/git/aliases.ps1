function fp            { g fp @args }
function fp-dr         { g fp-dr @args }

#`git lg' is aliased to `log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative'
function di            { g di @args }
function dik           { g dik @args }
function dt            { g diff temp }

function brk           { g brk @args }
function co            { g co @args }
function cob           { g cob @args }

function snap          { g add --all ; cim @args }

function Git-Divergence($branch1, $branch2)
{
  $ancestor = git merge-base $branch1 $branch2

  gitk "$ancestor..$branch1" "$ancestor..$branch2"
}
