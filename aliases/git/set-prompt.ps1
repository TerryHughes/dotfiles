function git_prompt() {
	$TopLevel = git --no-optional-locks rev-parse --show-toplevel
	if ("$TopLevel" -eq "") { return }
	$GitDirectory = "$TopLevel/.git"

	if (Test-Path "$GitDirectory" -PathType Leaf) {
		$GitDirectory = (Get-Content "$GitDirectory").Substring(8)
	}

	$Status = git --no-optional-locks status --porcelain=2 --branch --show-stash
	$CommitHash = ($Status | Where-Object { $_ -match " branch.oid " }).Substring(13)
	if ("$CommitHash" -ne "(initial)") {
		$CommitHash = $CommitHash.Substring(0, 7)
	}
	$Head = ($Status | Where-Object { $_ -match " branch.head " }).Substring(14)
	$Upstream = ($Status | Where-Object { $_ -match " branch.upstream " }).Substring(18)
	$ab = ($Status | Where-Object { $_ -match " branch.ab " }).Substring(12)
	$AheadCount  = $ab.Split(' ')[0].Substring(1)
	$BehindCount = $ab.Split(' ')[1].Substring(1)
	$Stash = ($Status | Where-Object { $_ -match " stash " }).Substring(8)

	$patterns = @("1", "2", "u", "?", "1")
	$counts = $Status | Where-Object { $patterns -contains $_.Substring(0, 1) }
	$MCountX = ($counts | Where-Object { $_.Substring(2, 1) -match "M" }).Count
	$MCountY = ($counts | Where-Object { $_.Substring(3, 1) -match "M" }).Count
	$RCountX = ($counts | Where-Object { $_.Substring(2, 1) -match "R" }).Count
	$RCountY = ($counts | Where-Object { $_.Substring(3, 1) -match "R" }).Count
	$DCountX = ($counts | Where-Object { $_.Substring(2, 1) -match "D" }).Count
	$DCountY = ($counts | Where-Object { $_.Substring(3, 1) -match "D" }).Count
	$ACountX = ($counts | Where-Object { $_.Substring(2, 1) -match "A" }).Count
	$ACountY = ($counts | Where-Object { $_.Substring(3, 1) -match "A" }).Count
	$UCountX = ($counts | Where-Object { $_.Substring(2, 1) -match "U" }).Count
	$UCountY = ($counts | Where-Object { $_.Substring(3, 1) -match "U" }).Count
	$TCountX = ($counts | Where-Object { $_.Substring(2, 1) -match "T" }).Count
	$TCountY = ($counts | Where-Object { $_.Substring(3, 1) -match "T" }).Count
	$CCountX = ($counts | Where-Object { $_.Substring(2, 1) -match "C" }).Count
	$CCountY = ($counts | Where-Object { $_.Substring(3, 1) -match "C" }).Count
	$qCount  = ($counts | Where-Object { $_.Substring(0, 1) -match "[?]" }).Count
	$eCount  = ($counts | Where-Object { $_.Substring(0, 1) -match "!" }).Count

	$prompt = "$CommitHash "
	if ("$Head" -eq "(detached)") {
		$BranchName = ""
		$Onto       = ""
		if (Test-Path "$GitDirectory/rebase-apply" -PathType Container) {
			if (Test-Path "$GitDirectory/rebase-apply/applying" -PathType Leaf) {
				$BranchName = (Get-Content "$GitDirectory/rebase-apply/head-name").Substring(11)
				$Onto       =  Get-Content "$GitDirectory/rebase-apply/onto"

				$prompt += "applying "
			}
		} else {
			$BranchName = (Get-Content "$GitDirectory/rebase-merge/head-name").Substring(11)
			$Onto       =  Get-Content "$GitDirectory/rebase-merge/onto"

			if (Test-Path "$GitDirectory/rebase-merge/interactive") {
				$prompt += "interactive "
			}
			$prompt += "rebasing "
		}
		$prompt += "'$BranchName' onto '$Onto.SubString(0, 7)'"
	} else {
		$prompt += "$Head"
	}
	if ("$Upstream" -ne "") {
		$prompt += "...$Upstream"
	}
	$Glyphs = $false
	$DistancePrefix = " ["
	$DistanceSuffix = "]"
	if (($AheadCount -gt 0) -or ($BehindCount -gt 0)) {
		$prompt += "$DistancePrefix"
		if ($Glyphs) {
			if ($AheadCount  -gt 0) { $prompt += "^$AheadCount"  }
			if ($BehindCount -gt 0) { $prompt += "v$BehindCount" }
		} else {
			if ($AheadCount  -gt 0) { $prompt += "ahead $AheadCount"   }
			if (($AheadCount -gt 0) -and ($BehindCount -gt 0)) { $prompt += ", " }
			if ($BehindCount -gt 0) { $prompt += "behind $BehindCount" }
		}
		$prompt += "$DistanceSuffix"
	} elseif ("$Upstream" -ne "") {
		if ($Glyphs) {
			$prompt += "$DistancePrefix/$DistanceSuffix"
		}
	} else {
		if ($Glyphs) {
			$prompt += "$DistancePrefixX$DistanceSuffix"
		}
	}
	if ("$Stash" -ne "") {
		$prompt += " stash@{$Stash}"
	}

	if (($MCountX -gt 0) -or ($MCountY -gt 0)) {
		$prompt += " M:"
		if ($MCountX -gt 0) { $prompt += "$MCountX" }
		if (($MCountX -gt 0) -and ($MCountY -gt 0)) { $prompt += "," }
		if ($MCountY -gt 0) { $prompt += "$MCountY" }
	}
	if (($RCountX -gt 0) -or ($RCountY -gt 0)) {
		$prompt += " R:"
		if ($RCountX -gt 0) { $prompt += "$RCountX" }
		if (($RCountX -gt 0) -and ($RCountY -gt 0)) { $prompt += "," }
		if ($RCountY -gt 0) { $prompt += "$RCountY" }
	}
	if (($DCountX -gt 0) -or ($DCountY -gt 0)) {
		$prompt += " D:"
		if ($DCountX -gt 0) { $prompt += "$DCountX" }
		if (($DCountX -gt 0) -and ($DCountY -gt 0)) { $prompt += "," }
		if ($DCountY -gt 0) { $prompt += "$DCountY" }
	}
	if (($ACountX -gt 0) -or ($ACountY -gt 0)) {
		$prompt += " A:"
		if ($ACountX -gt 0) { $prompt += "$ACountX" }
		if (($ACountX -gt 0) -and ($ACountY -gt 0)) { $prompt += "," }
		if ($ACountY -gt 0) { $prompt += "$ACountY" }
	}
	if (($UCountX -gt 0) -or ($UCountY -gt 0)) {
		$prompt += " U:"
		if ($UCountX -gt 0) { $prompt += "$UCountX" }
		if (($UCountX -gt 0) -and ($UCountY -gt 0)) { $prompt += "," }
		if ($UCountY -gt 0) { $prompt += "$UCountY" }
	}
	if (($TCountX -gt 0) -or ($TCountY -gt 0)) {
		$prompt += " T:"
		if ($TCountX -gt 0) { $prompt += "$TCountX" }
		if (($TCountX -gt 0) -and ($TCountY -gt 0)) { $prompt += "," }
		if ($TCountY -gt 0) { $prompt += "$TCountY" }
	}
	if (($CCountX -gt 0) -or ($CCountY -gt 0)) {
		$prompt += " C:"
		if ($CCountX -gt 0) { $prompt += "$CCountX" }
		if (($CCountX -gt 0) -and ($CCountY -gt 0)) { $prompt += "," }
		if ($CCountY -gt 0) { $prompt += "$CCountY" }
	}
	if ($qCount -gt 0) { $prompt += " ?:$qCount" }
	if ($eCount -gt 0) { $prompt += " !:$eCount" }
	write "$prompt"
}

git_prompt
