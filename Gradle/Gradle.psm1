Set-Alias g			GradleWrapper
Set-Alias gversion	SetGradleVersion

$global:moduleDirPath = "$args\Gradle"

function GradleWrapper{
	iex "$global:moduleDirPath\gradlew.bat $args"
}

function SetGradleVersion{
	pushd $global:moduleDirPath
	GradleWrapper "wrapper" "-PnewVersion='$args'"
	popd
}

Export-ModuleMember -Function *
Export-ModuleMember -Variable ''
Export-ModuleMember -Alias *