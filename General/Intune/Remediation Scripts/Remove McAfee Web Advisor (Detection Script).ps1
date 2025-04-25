#Scan for McAfee Web Advisor (Detection Script)
if (Test-Path 'C:\Program Files\McAfee\WebAdvisor') {
    Write-Host McAffee Web Advisor Installed
    Exit 1
  }
  Else {
    Write-Host McAffee Web Advisor Not Installed
    Exit 0
  }