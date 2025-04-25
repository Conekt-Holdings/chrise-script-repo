$WPADSetting = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp' -Name DisableWpad

if ($WPADSetting.DisableWpad -eq 1) {
  Write-Host "STATUS=WPAD is Disabled with value $WPADSetting.DisableWpad"
  Exit 0
}
else {
  Write-Host "ALERT=WPAD is Enabled"
  Exit 1 
}
