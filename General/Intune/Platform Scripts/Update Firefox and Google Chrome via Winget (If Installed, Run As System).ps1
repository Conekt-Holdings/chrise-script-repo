#This script will NOT install the apps, but will update them if present
# Find Winget Directory
$wgdir=(Get-Childitem -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller*" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
# Move to WinGet Directory
cd $wgdir
.\winget.exe upgrade --id=Google.Chrome -e --accept-package-agreements --accept-source-agreements
.\winget.exe upgrade --id=mozilla.firefox -e --accept-package-agreements --accept-source-agreements