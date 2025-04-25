$maxProfileAge = Get-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name CleanupProfiles

if ($maxProfileAge.CleanupProfiles -eq 90) {

  Write-Host '<-Start Result->'
  Write-Host "STATUS=Max Profile Age value is set to $maxProfileAge.CleanupProfiles"
  Write-Host '<-End Result->'

  Exit 0

} else {

  Write-Host '<-Start Result->'
  Write-Host "ALERT=Max Profile Age value not set or incorrect!"
  Write-Host '<-End Result->'

  Exit 1
  
}
