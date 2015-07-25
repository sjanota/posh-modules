PowerShell modules
==================

## Before install

Before installation of any module be sure, that path to folder with modules is in your PSModulesPath environmental variable. If cloning whole repo you can add following lines to your profile file:
```
$modulesRepo = "path/to/this/cloned/repo"
$env:PSModulePath = $env:PsModulePath + ";$modulesRepo"
```

You can check if your profile file exists. If following command returns True it means profile file exists
```
Test-Path $Profile
```

Envirpnmental variable ```$Profile``` contains path to your profile file. If it does not exists you can  create it with command:
```
New-Item -path $profile -type file -force
```

Before using modules it may be needed to enable script execution. Following does exactly that:
```
Set-ExecutionPolicy RemoteSigned
```

## GitOperations module

### Installation

To use this module simply add following lines to your profile file when module folder is in your PSModulePath
```
Import-Module GitOperations
```

## Idea module

### Installation

To use this module simply add following lines to your profile file when module folder is in your PSModulePath
```
Import-Module Idea
```

## Gradle module

### Installation

To use this module simply add following lines to your profile file when module folder is in your PSModulePath
```
Import-Module Gradle -ArgumentList /path/to/folder/with/Gradle
```
where /path/to/folder/with/Gradle is path to folder where Gradle module is stored. It could be simply
```
Import-Module Gradle -ArgumentList "$modulesRepo"
```
when using variable $modulesRepo described at the begining.
