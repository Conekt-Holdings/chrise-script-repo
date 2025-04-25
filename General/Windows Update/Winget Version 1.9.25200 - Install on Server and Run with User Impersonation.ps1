# PS Remoting Not Working as intended, so this script is informational only

#PS Remoting required for running script as SYSTEM
Enable-PSRemoting -SkipNetworkProfileCheck -Force
winrm s winrm/config/client '@{TrustedHosts="localhost"}'

#Create Temp User Account
net user /add wingetinstall 'bN,7d9qg!h@{BL'
net localgroup administrators /add wingetinstall

$pw = 'bN,7d9qg!h@{BL'
$username = '.\wingetinstall'
$password = $pw | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password
$Session = New-PSSession -Credential $cred
Invoke-Command -Session $Session -Scriptblock {

mkdir C:\winget
cd C:\winget

#Install VC
#WARNING - THIS MAY CAUSE A REBOOT IF INSTALLATION / UPGRADE IS REQUIRED
wget "https://aka.ms/vs/17/release/vc_redist.x64.exe" -Outfile C:\vcredist_x64.exe
Start-Process -FilePath “C:\vcredist_x64.exe” -ArgumentList “/Q” -Wait

# Install VCLibs
Add-AppxPackage 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

# Install Microsoft.UI.Xaml.2.8.6 from NuGet
Invoke-WebRequest -Uri https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6 -OutFile .\microsoft.ui.xaml.2.8.6.zip
Expand-Archive .\microsoft.ui.xaml.2.8.6.zip -force
Add-AppxPackage .\microsoft.ui.xaml.2.8.6\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx

# Install the latest release of Microsoft.DesktopInstaller from GitHub
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile .\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.9.25200/7fdfd40ea2dc40deab85b69983e1d873_License1.xml -OutFile .\7fdfd40ea2dc40deab85b69983e1d873_License1.xml
Add-AppxProvisionedPackage -Online -PackagePath .\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -LicensePath .\7fdfd40ea2dc40deab85b69983e1d873_License1.xml -Verbose

$folderMask = "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*"
$folders = Get-ChildItem -Path $folderMask -Directory | Where-Object { $_.Name -like "*_x64_*" }
foreach ($folder in $folders) {
    $folderPath = $folder.FullName
    TAKEOWN /F $folderPath /R /A /D Y
    ICACLS $folderPath /grant Administrators:F /T
}

# Find Winget Directory
$wgdir=(Get-Childitem -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller*" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
# Move to WinGet Directory
cd $wgdir
#Run Winget Upgrade All (first upgrade machine-scoped apps, then user scoped apps)
.\winget.exe upgrade --all --accept-package-agreements --accept-source-agreements --scope=machine
.\winget.exe upgrade --all --accept-package-agreements --accept-source-agreements

}

net user /delete wingetinstall

cd C:\

Remove-Item C:\winget -Recurse -Force
Remove-Item C:\vcredist_x64.exe -Force
