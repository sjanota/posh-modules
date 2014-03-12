PowerShell modules
==================

# Before install

Before installation of any module be sure, that path to folder with modules is in your PSModulesPath environmental variable. If cloning whole repo you can add following lines to your profile file:
```
$modulesRepo = "path/to/this/cloned/repo"
$env:PSModulePath = $env:PsModulePath + ";$modulesRepo"
```

# GitOperations module

## Installation

To use this module simply add following lines to your profile file
```
Import-Module GitOperations
```
