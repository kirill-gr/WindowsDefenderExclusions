# TODO vars on top (like IntelliJ version)
# List of tools:
# Java
# Kotlin
# Maven
# Gradle
# Python
# NodeJS
# Git (wslgit?)
# databases?
# See: https://medium.com/burak-tasci/tweaking-the-environment-to-speed-up-visual-studio-79cd1920fed9
$userPath = $env:USERPROFILE
$pathExclusions = New-Object System.Collections.ArrayList
$processExclusions = New-Object System.Collections.ArrayList

# IDE
$pathExclusions.Add($userPath + '\.IntelliJIdea2019.2') > $null
#$pathExclusions.Add('$userPath\AppData\Local\Jetbrains') > $null
#$pathExclusions.Add('$userPath\AppData\Roaming\JetBrains') > $null

# Cache Folders
$pathExclusions.Add($userPath + '\.m2') > $null
$pathExclusions.Add($userPath + '\.gradle') > $null
#$pathExclusions.Add('$userPath\AppData\Roaming\npm') > $null
#$pathExclusions.Add('$userPath\AppData\Roaming\npm-cache') > $null

# Runtimes, build tools
#$pathExclusions.Add('$userPath\AppData\Local\kotlin') > $null
#$pathExclusions.Add('C:\ProgramData\MySQL') > $null
#$pathExclusions.Add('C:\ProgramData\Git') > $null
#$pathExclusions.Add('C:\Program Files (x86)\MySQL') > $null
#$pathExclusions.Add('C:\Program Files\MySQL') > $null
#$pathExclusions.Add('C:\Program Files\Git') > $null
# TODO use java dir
# TODO use node dir
# TODO use python dir
# TODO use process exclusions?
#$processExclusions.Add('java.exe') > $null
#$processExclusions.Add('java64.exe') > $null
#$processExclusions.Add('node.exe') > $null
#$processExclusions.Add('node.js') > $null
#$processExclusions.Add('mysqld.exe') > $null
#$processExclusions.Add('git.exe') > $null

# Shells
#$processExclusions.Add('git-bash.exe') > $null
#$processExclusions.Add('bash.exe') > $null
#$processExclusions.Add('powershell.exe') > $null

# All of JetBrains stuff
#$processExclusions.Add('elevator.exe') > $null
#$processExclusions.Add('fsnotifier.exe') > $null
#$processExclusions.Add('fsnotifier64.exe') > $null
#$processExclusions.Add('launcher.exe') > $null
# TODO use intellij dir?
#$processExclusions.Add('idea.exe') > $null
#$processExclusions.Add('idea64.exe') > $null

Write-Host "This script will create Windows Defender exclusions for common folders used by development tools"
Write-Host "Must be run with administrator rights"
Write-Host ""
$projectsFolder = Read-Host 'What is the path to your Projects folder? (example: c:\projects)'

Write-Host ""
Write-Host "Adding Path Exclusion: " $projectsFolder
Add-MpPreference -ExclusionPath $projectsFolder

foreach ($exclusion in $pathExclusions) 
{
    Write-Host "Adding Path Exclusion: " $exclusion
    Add-MpPreference -ExclusionPath $exclusion
}

foreach ($exclusion in $processExclusions)
{
    Write-Host "Adding Process Exclusion: " $exclusion
    Add-MpPreference -ExclusionProcess $exclusion
}

Write-Host ""
Write-Host "Your Exclusions:"

$prefs = Get-MpPreference
$prefs.ExclusionPath
$prefs.ExclusionProcess

Write-Host ""
Write-Host "Enjoy faster build times and coding!"
Write-Host ""
