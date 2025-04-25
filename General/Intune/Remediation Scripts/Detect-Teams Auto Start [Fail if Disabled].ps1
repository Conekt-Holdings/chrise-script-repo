# Detection if NEW Teams Autostart is enabled
$rpath = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MSTeams_8wekyb3d8bbwe\TeamsTfwStartupTask"

try {
    $v = Get-ItemPropertyValue -Path $rpath -Name "State" -ErrorAction Stop

    if ($v -eq "0") {
        Write-Output "Autostart NEW Teams is Disabled"
        exit 1
    } else {
        Write-Output "Autostart NEW Teams is Enabled"
        exit 0
    }
} catch {
    Write-Output "Error: $_"
    Write-Output "NEW Teams is probably not installed and does not need to be disabled"
    exit 0
}