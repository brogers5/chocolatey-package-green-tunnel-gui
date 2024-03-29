﻿$ErrorActionPreference = 'Stop'

$currentPath = (Split-Path $MyInvocation.MyCommand.Definition)
. $currentPath\helpers.ps1

$nuspecFileRelativePath = Join-Path -Path $currentPath -ChildPath 'green-tunnel-gui.nuspec'

[xml] $nuspec = Get-Content $nuspecFileRelativePath
$version = [Version] $nuspec.package.metadata.version

$global:Latest = @{
    Url32   = Get-SoftwareUri -Version $version
    Version = $version
}

Write-Verbose 'Downloading...'
Get-RemoteFiles -Purge -NoSuffix

Write-Verbose 'Creating package...'
choco pack $nuspecFileRelativePath
