$iconsDir = Join-Path $PSScriptRoot "icons"

$groups = @{
    "windows-95"   = "w95_"
    "windows-98"   = "w98_"
    "windows-2000" = "w2k"
    "windows-xp"   = "wxp_"
}

foreach ($dirName in $groups.Keys) {
    $prefix = $groups[$dirName]
    $destDir = Join-Path $iconsDir $dirName

    $files = Get-ChildItem -Path $iconsDir -File | Where-Object { $_.Name -like "$prefix*" }

    if ($files.Count -eq 0) {
        Write-Host "No files found for prefix '$prefix', skipping."
        continue
    }

    New-Item -ItemType Directory -Path $destDir -Force | Out-Null

    foreach ($file in $files) {
        Move-Item -Path $file.FullName -Destination $destDir
    }

    Write-Host "Moved $($files.Count) files to $dirName"
}
