#Scan for Winget (Detection Script)
if (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe") {
    Write-Host Winget Is Installed, Proceeding with Update / Installation Scripts
    Exit 1
  }
  Else {
    Write-Host Winget is Not installed, stopping process
    Exit 0
  }