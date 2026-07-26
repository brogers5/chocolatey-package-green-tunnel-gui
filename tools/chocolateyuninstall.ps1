$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'GreenTunnel *'
  fileType       = 'EXE'
  silentArgs     = '/allusers /S'
  validExitCodes = @(0)
}

[array] $keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($keys.Count -eq 1) {
  $keys | ForEach-Object {
    $packageArgs['file'] = "$(($_.UninstallString.TrimEnd('/allusers')).Replace('"', ''))"
    Uninstall-ChocolateyPackage @packageArgs
  }
}
elseif ($keys.Count -eq 0) {
  Write-Warning "$env:ChocolateyPackageName has already been uninstalled by other means."
}
elseif ($keys.Count -gt 1) {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning 'To prevent accidental data loss, no programs will be uninstalled.'
  Write-Warning 'Please alert package maintainer the following keys were matched:'
  $keys | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
