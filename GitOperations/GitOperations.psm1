Set-Alias gs 		GitStatus
Set-Alias ga 		GitAdd
Set-Alias gaa 		GitAddAll
Set-Alias gitka 	GitkAll
Set-Alias gcp 		GitCommitPush
Set-Alias gch		GitCheckout
Set-Alias gcom		GitFullCommit
Set-Alias gup		GitUpdate
Set-Alias guname	SetUsername
Set-Alias gumail	SetUserEmail
Set-Alias gcname	SetCommitname
Set-Alias gignore	GitIgnore
Set-Alias gsub		GitSubmoduleUpdate
Set-Alias gsubi		GitSubmoduleInit
Set-Alias gresh		GitResetHard
Set-Alias gcf		GitCheckoutFeature
Set-Alias gfsuffix  SetFeatureSuffix

# Variables
$gitDefaultUsername = "gituser"
$gitDefaultFeatureSuffix = "feature"

# Basic Git operations
function GitStatus{
	git status
}
function GitAdd{
	git add $args
}
function GitCheckout{
	git checkout $args
}
function GitCommit{
	git commit $args
}
function GitRebase{
	git rebase $args
}
function GitPush($remote,$branch){
	git push $remote $branch
}
function GitStash{
	git stash $args
}
function GitPull{
	git pull $args
}
function GitIgnore{
	foreach ($arg in $args){
		"$arg" | add-content ".gitignore"
	}
}
function GitInit{
	git init
}
function GitSetOrigin{
	git remote set-url origin $args
}

# Complex Git scenarios
function GitFullCommit([parameter(Mandatory=$true)]$message, [parameter(Mandatory=$false)]$branch = "master"){	
	$featureBranch = GetFeatureBranch($branch)
	$username = $env:COMMITUSERNAME
	GitCheckout($featureBranch)
	GitCommit "-m" "${username}$message"
}
function GitCommitPush($message, $branch = "master"){
	if($message -ne $null){ GitFullCommit $message $branch }
	$featureBranch = GetFeatureBranch($branch)
	GitCheckout($branch)
	GitRebase($featureBranch)
	GitPush "origin" $branch
	GitCheckout($featureBranch)
}
function GitUpdate($branch = "master"){
	$featureBranch = GetFeatureBranch($branch)
	GitCheckout($branch)
	GitPull "origin" $branch
	GitCheckout($featureBranch)
	GitStash
	GitRebase($branch)
	GitStash("pop")
}

# Git configuration
function SetUserEmail{
	$email = $args[0]
	echo("Setting user.email to : $email")
	git config --global user.email $email
}
function SetUsername{
	$username = $args[0]
	echo("Setting user.name to : $username")
	git config --global user.name $username
}
function SetFeatureSuffix{
	$suffix = $args[0]
	if($suffix -eq "-r"){ $suffix = $gitDefaultFeatureSuffix }
	echo("Setting GITFEATURESUFFIX to : $suffix")
	[Environment]::SetEnvironmentVariable("GITFEATURESUFFIX", $suffix, "User")
}
function SetCommitname{
	$username = "${args[0]}: "
	if($username -eq "-r"){ $username = "" }
	echo("Setting COMMITUSERNAME to : $username")
	[Environment]::SetEnvironmentVariable("COMMITUSERNAME", $username, "User")
}

if($env:GITFEATURESUFFIX -eq $null){
	SetFeatureSuffix($gitDefaultFeatureSuffix)
}
if($env:COMMITUSERNAME -eq $null){
	SetCommitname("")
}

# Others
function GitSubmoduleUpdate {
	git submodule update --recursive
}
function GitCheckoutFeature([parameter(Mandatory=$false)] $branch = "master") {
	$featureBranch = GetFeatureBranch $branch
	$featureExists = GitBranchExists $featureBranch
	IF ( $featureExists -eq $true ) {
		GitCheckout $featureBranch
	} ELSE {
		GitCheckout -b $featureBranch
	}
	
}
function GitBranchExists([parameter(Mandatory=$true)] $branch)  {
	git rev-parse --verify $branch > $null
	IF( $LastExitCode -eq 0 ) { $true }
	ELSE { $false }
}
function GitSubmoduleInit {
	git submodule update --init --recursive
}
function GitResetHard {
	git reset HEAD --hard
}
function GitAddAll{
	GitAdd("--all")
}
function GitkAll{
	gitk --all
}
function GitHubClone([parameter(Mandatory=$true)]$project,[parameter()]$user = $env:GITUSERNAME ){
	$repoPath = GithubPath $project $user
	echo $repoPath
	git clone $repoPath
	cd $project
	GitCheckout "-b" "feature" 
	cd ..
}

# Helpers
function GetFeatureBranch($branch = "master"){
	$featureBranch = "$branch-${env:GITFEATURESUFFIX}"
	if($branch -eq "master"){ $featureBranch = "${env:GITFEATURESUFFIX}" }
	$featureBranch
}
function GithubPath($project,$user){
	"git@github.com:$user/${project}.git"
}

# Exports
Export-ModuleMember -Function *
Export-ModuleMember -Variable ''
Export-ModuleMember -Alias *
