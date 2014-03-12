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

To use this module simply add following lines to your profile file when module folder is in your PSModulePath
```
Import-Module GitOperations
```

# Idea module

## Installation

To use this module simply add following lines to your profile file when module folder is in your PSModulePath
```
Import-Module Idea
```

# Gradle module

## Installation

To use this module simply add following lines to your profile file when module folder is in your PSModulePath
```
Import-Module Gradle -ArgumentList /path/to/folder/with/Gradle
```
where /path/to/folder/with/Gradle is path to folder where Gradle module is stored. It could be simply
```
Import-Module Gradle -ArgumentList "$modulesRepo"
```
when using variable $modulesRepo described at the begining.
