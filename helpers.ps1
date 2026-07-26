Import-Module PowerShellForGitHub

$installerFileNameRegex = 'GreenTunnel\.Setup\.\d\.\d\.\d\.exe$'
$owner = 'SadeghHayeri'
$repository = 'GreenTunnel'

function Get-LatestStableVersion {
    $latestRelease = (Get-GitHubRelease -OwnerName $owner -RepositoryName $repository -Latest)[0]

    return [Version] $latestRelease.tag_name.Substring(1)
}

function Get-SoftwareUri {
    [CmdletBinding()]
    param(
        [Version] $Version
    )

    if ($null -eq $Version) {
        # Default to latest stable version
        $release = (Get-GitHubRelease -OwnerName $owner -RepositoryName $repository -Latest)[0]
    }
    else {
        $release = Get-GitHubRelease -OwnerName $owner -RepositoryName $repository -Tag "v$($Version.ToString())"
    }
    $releaseAssets = Get-GitHubReleaseAsset -OwnerName $owner -RepositoryName $repository -Release $release.ID

    $windowsBinaryAsset = $null
    foreach ($asset in $releaseAssets) {
        if ($asset.name -match $installerFileNameRegex) {
            $windowsBinaryAsset = $asset
            break
        }
        else {
            continue
        }
    }

    if ($null -eq $windowsBinaryAsset) {
        throw 'Cannot find published Windows binary asset!'
    }

    return $windowsBinaryAsset.browser_download_url
}