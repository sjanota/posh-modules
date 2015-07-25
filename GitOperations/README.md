GitOperations PowerShell module
===============================

## Configuration

GitOperations uses environmetal varaibles to set following properties:

 * GITCOMMITNAME - Can be set via gcuser command. If supplied all commit messages will be prefixed with '$GITCOMMITNAME: '
 * GITFEAUTRESUFFIX - Cen be set via gfsuffix command. It is suffix that will be applied to feature branches.

## Defined aliases

 * $branch defaults to master 
 * feature branch suffix defaults to 'feature'

<table>
	<tr><td>Alias</td><td>Description</td></tr>	

	<tr><td>gcname $username</td><td>Sets GITCOMMITNAME. If '-r' is passed instead its value is uset</td></tr>

	<tr><td>guname $username</td><td>Sets user.name in config</td></tr>

	<tr><td>gumail $username</td><td>Sets user.email in config</td></tr>

	<tr><td>gfsuffix $username</td><td>Setsfeature branch suffix</td></tr>

	<tr><td>gs</td><td>git status</td></tr>

	<tr><td>ga $args</td><td>git add $args</td></tr>

	<tr><td>gaa</td><td>git add --all</td></tr>

	<tr><td>gitka</td><td>gitk --all</td></tr>

	<tr><td>gcf ($branch)</td><td>Checkout feature branch for specified branch (feature for master or in format {branch}-feature for any other branch). Create if absent

	<tr><td>gcom $message ($branch)</td><td>Commits all staged changes with $message (with prefix if commitname specified) on feature branch for specified branch</td></tr>

	<tr><td>gcp ($message) ($branch)</td><td>Acts like gcom, but also rebase $branch onto feature and push changes to origin. If message is not specified only push will be performed</td></tr>

	<tr><td>gch $args</td><td>git checkout $args</td></tr>

	<tr><td>gup ($branch)</td><td>Stash changes, checkout $branch, pull changes from upstream. Then rebase feature onto $branch and pop stash</td></tr>

	<tr><td>gignore $args</td><td>All $args are added to content of .gitignore</td></tr>

	<tr><td>gsub</td><td>git submodule update --recursive</td></tr>

	<tr><td>gsubi</td><td>git submodule update --init --recursive</td></tr>

	<tr><td>gresh</td><td>git reset --hard HEAD</td></tr>
</table>
