Set-Alias gs 		GitStatus
Set-Alias ga 		GitAdd
Set-Alias gaa 		GitAddAll
Set-Alias gitka 	GitkAll
Set-Alias gcp 		GitCommitPush
Set-Alias gch		GitCheckout
Set-Alias gcom		GitFullCommit
Set-Alias gup		GitUpdate
Set-Alias guser		SetUsername
Set-Alias gcuser	SetCommitname
Set-Alias ghclone	GitHubClone
Set-Alias gignore	GitIgnore
Set-Alias ginit		GitFullInit

# Variables
$gitDefaultUsername = "gituser"

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
function GitFullCommit([parameter(Mandatory=$true)]$branch ,[parameter(Mandatory=$true)]$message){	
	$featureBranch = GetFeatureBranch($branch)
	$username = $env:COMMITUSERNAME
	GitCheckout($featureBranch)
	GitCommit "-m" "${username}: $message"
}
function GitCommitPush($message, $branch = "master"){
	if($message -ne $null){ GitFullCommit $branch $message }
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
function GitFullInit([parameter(Mandatory=$true)]$repoName, [parameter()]$user = $env:GITUSERNAME ){
	$readme = "README.md"
	GitInit
	echo("$repoName") | Out-File $readme
	GitAdd $readme
	GitCommit "-m" "Initial commit"
	GitCheckout "-b" "feature"
	$origin = GithubPath $repoName $user
	GitSetOrigin $origin
}

# Git configuration
function SetUsername{
	$username = $args[0]
	if($username -eq "-r"){ $username = $gitDefaultUsername }
	echo("Setting GITUSERNAME to : $username")
	[Environment]::SetEnvironmentVariable("GITUSERNAME", $username, "User")
}
function SetCommitname{
	$username = $args[0]
	if($username -eq "-r"){ $username = $gitDefaultUsername }
	echo("Setting COMMITUSERNAME to : $username")
	[Environment]::SetEnvironmentVariable("COMMITUSERNAME", $username, "User")
}
if($env:GITUSERNAME -eq $null){
	Set-Username($gitDefaultUsername)
}
if($env:COMMITUSERNAME -eq $null){
	Set-Commitname($gitDefaultUsername)
}

# Others
function GitAddAll{
	GitAdd("--all")
}
function GitkAll{
	gitk --all
}
function GitHubClone([parameter(Mandatory=$true)]$project,[parameter()]$user = $env:GITUSERNAME ){
	$repoPath = GithubPath $project $user
	git clone $repoPath
	cd $project
	GitCheckout "-b" "feature" 
	cd ..
}

# Helpers
function GetFeatureBranch($branch = "master"){
	$featureBranch = "$branch-feature"
	if($branch -eq "master"){ $featureBranch = "feature" }
	$featureBranch
}
function GithubPath($project,$user){
	"git@github.com:$user/${project}.git"
}

# Exports
Export-ModuleMember -Function *
Export-ModuleMember -Variable ''
Export-ModuleMember -Alias *
