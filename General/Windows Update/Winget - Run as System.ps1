#Install VC Dependancies if not already installed
#WARNING - THIS MAY CAUSE A REBOOT IF INSTALLATION / UPGRADE IS REQUIRED
wget "https://aka.ms/vs/17/release/vc_redist.x64.exe" -Outfile C:\vcredist_x64.exe
Start-Process -FilePath “C:\vcredist_x64.exe” -ArgumentList “/Q” -Wait
Remove-Item C:\vcredist_x64.exe -Force
# Find Winget Directory
$wgdir=(Get-Childitem -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller*" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
# Move to WinGet Directory
cd $wgdir
#Run Winget Upgrade All (first upgrade machine-scoped apps, then user scoped apps)
.\winget.exe upgrade --all --accept-package-agreements --accept-source-agreements --scope=machine
.\winget.exe upgrade --all --accept-package-agreements --accept-source-agreements
