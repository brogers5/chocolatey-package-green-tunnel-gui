$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$legacySquirrelInstallation = Get-LegacySquirrelInstallation
if ($null -ne $legacySquirrelInstallation -and ((Get-OSArchitectureWidth -Compare 64) -and ($env:chocolateyForceX86 -ne $true))) {
  Write-Warning "A legacy version of Green Tunnel (v$($legacySquirrelInstallation.DisplayVersion)) was detected.
      Green Tunnel has since migrated to a separate installer implementation that does not clean up legacy installations.
      To prevent possible issues with installation coexistence, please manually uninstall this version at your earliest convenience."
}

$installerFileName = 'GreenTunnel.Setup.3.0.5.exe'
$filePath = Join-Path -Path $toolsDir -ChildPath $installerFileName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file64         = $filePath
  softwareName   = 'GreenTunnel *'
  silentArgs     = '/ALLUSERS /S'
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

#Remove installer binary post-install to prevent disk bloat
Remove-Item $filePath -Force -ErrorAction SilentlyContinue

#If installer binary removal fails for some reason, prevent an installer shim from being generated
if (Test-Path -Path $filePath) {
  Set-Content -Path "$filePath.ignore" -Value $null -ErrorAction SilentlyContinue
}
