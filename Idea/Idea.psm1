Set-Alias idea 	IdeaHome

function IdeaHome($project){
	cd $home\IdeaProjects\$project
}

Export-ModuleMember -Function *
Export-ModuleMember -Variable ''
Export-ModuleMember -Alias *