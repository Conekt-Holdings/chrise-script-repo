$LPE = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name LongPathsEnabled

if ($LPE.LongPathsEnabled -eq 1) {

   Write-Host "STATUS - Long Paths Enabled"
   Exit 0

} else {

  Write-Host "ALERT - Long Paths Disabled"
  Exit 1
  
}