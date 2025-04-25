# Find Winget Directory
$wgdir=(Get-Childitem -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller*" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
# Move to WinGet Directory
cd $wgdir

#Install Adobe Reader
if (Resolve-Path "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe") {
    Write-Host Adobe Reader is Installed
}
Else {
    Write-Host Adobe Reader Not Installed, Proceeding with Installation
    .\winget.exe install --id=Adobe.Acrobat.Reader.64-bit -e --accept-package-agreements --accept-source-agreements
}
#Install 7Zip
if (Resolve-Path "C:\Program Files\7-Zip\7zFM.exe") {
    Write-Host 7zip is Installed
}
Else {
    Write-Host 7zip is not  installed, proceeding with installation
    .\winget.exe install --id=7zip.7zip -e --accept-package-agreements --accept-source-agreements
}
#Install Google Chrome
if (Resolve-Path "C:\Program Files\Google\Chrome\Application\Chrome.exe") {
    Write-Host Google Chrome is Installed
}
Else {
    Write-Host Google Chrome is not installed, proceeding with installation
    .\winget.exe install --id=Google.Chrome -e --accept-package-agreements --accept-source-agreements
}
#Install Citrix Workspace
if (Resolve-Path "C:\Program Files (x86)\Citrix\ICA Client\SelfServicePlugin\SelfService.exe") {
    Write-Host Citrix Workspace is Installed
}
Else {
    Write-Host Citrix Workspace is not installed, proceeding with installation
    .\winget.exe install --id=Citrix.Workspace -e --accept-package-agreements --accept-source-agreements
}