#This script will NOT install the apps, but will update them if present
# Find Winget Directory
$wgdir=(Get-Childitem -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller*" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
# Move to WinGet Directory
cd $wgdir
#Update Google Chrome
.\winget.exe upgrade --id=Google.Chrome -e --accept-package-agreements --accept-source-agreements
#Update OneDrive
.\winget.exe upgrade --id=Microsoft.OneDrive -e --accept-package-agreements --accept-source-agreements
#Update Teams
.\winget.exe upgrade --id=Microsoft.Teams -e --accept-package-agreements --accept-source-agreements
#Update Adobe Reader
.\winget.exe upgrade --id=Adobe.Acrobat.Reader.64-bit -e --accept-package-agreements --accept-source-agreements
#Update 7zip
.\winget.exe upgrade --id=7zip.7zip -e --accept-package-agreements --accept-source-agreements
#Update Citrix Workspace
.\winget.exe upgrade --id=Citrix.Workspace -e --accept-package-agreements --accept-source-agreements