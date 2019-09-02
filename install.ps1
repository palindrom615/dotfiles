# For creating symbolic link with powershell, you should enable developer
# features or execute this script with administrator previliege.

New-Item -Path ~\.config -ItemType directory

Get-ChildItem $PSScriptRoot\APPDATA | ForEach-Object -Process {
	New-Item -Path $env:APPDATA -Name $_.Name -ItemType symboliclink -Value $_.FullName
}

Get-ChildItem $PSScriptRoot\XDG_CONFIG_HOME | ForEach-Object -Process {
	New-Item -Path ~\.config -Name $_.Name -ItemType symboliclink -Value $_.FullName
}

Get-ChildItem $PSScriptRoot\HOME | ForEach-Object -Process {
	New-Item -Path ~ -Name $_.Name -ItemType symboliclink -Value $_.FullName
}
