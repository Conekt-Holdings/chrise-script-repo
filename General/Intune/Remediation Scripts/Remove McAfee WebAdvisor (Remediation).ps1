#Remove McAfee Web Advisor (Remediation Script)
cd "C:\Program Files\McAfee\WebAdvisor"
.\uninstaller.exe /s
#Confirm that McAfee Was Removed
if (Test-Path 'C:\Program Files\McAfee\WebAdvisor') {
    Write-Host McAffee Web Advisor Installed
    Exit 1
  }
  Else {
    Write-Host McAffee Web Advisor Not Installed
    Exit 0
  }