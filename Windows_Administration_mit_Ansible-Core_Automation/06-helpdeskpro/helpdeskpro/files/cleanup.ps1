# cleanup.ps1 - Automatisches Wartungsskript für HelpDeskPro
# Löscht Logfiles, die älter als 15 Tage sind.

Set-Content -Path "C:\Program Files\HelpDeskPro\Logs\TestWrite.txt" -Value "Erfolgreich"

$TargetFolder = "C:\Program Files\HelpDeskPro\Logs"
$RetentionDays = 15
$CutoffDate = (Get-Date).AddDays(-$RetentionDays)

Write-Host "--- Starting Cleanup Task ---"
Write-Host "Target: $TargetFolder"
Write-Host "Deleting files older than: $CutoffDate"

if (Test-Path $TargetFolder) {
    # Suche Dateien, die älter als das Stichtagsdatum sind
    $OldFiles = Get-ChildItem -Path $TargetFolder -File | Where-Object { $_.LastWriteTime -lt $CutoffDate }

    if ($OldFiles) {
        foreach ($File in $OldFiles) {
            Write-Host "Deleting: $($File.Name) (Last Modified: $($File.LastWriteTime))"
            Remove-Item $File.FullName -Force -ErrorAction SilentlyContinue
        }
        Write-Host "Cleanup complete. Removed $($OldFiles.Count) files."
    } else {
        Write-Host "No files found older than $RetentionDays days."
    }
} else {
    Write-Warning "Directory not found: $TargetFolder"
}

Write-Host "--- Task Finished ---"