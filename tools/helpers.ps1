function Get-LegacySquirrelInstallation {
    [array] $keys = Get-UninstallRegistryKey -SoftwareName 'green-tunnel'
    if ($keys.Length -ge 1) {
        return $keys[0]
    }
  
    return $null
}
