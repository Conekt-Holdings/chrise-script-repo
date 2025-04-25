Start-Transcript -Path "$env:TEMP\DisableAutostartBothTeams.log" | Out-Null

# Modify State Key to disable New Teams
$hpath = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MSTeams_8wekyb3d8bbwe\TeamsTfwStartupTask"

if (Test-Path $hpath) {
    # Modify State
    Set-ItemProperty -Path $hpath -Name "State" -Value "2"

    # Modify LastDisabledTime
    $epoch = (Get-Date -Date ((Get-Date).DateTime) -UFormat %s)
    Set-ItemProperty -Path $hpath -Name "LastDisabledTime" -Value $epoch

    Write-Host "Autostart NEW Teams has been Enabled"
} else {
    Write-Host "NEW Teams is not found"
}

Write-Host "Disable Autostart of Teams configuration completed."


Stop-Transcript -Verbose