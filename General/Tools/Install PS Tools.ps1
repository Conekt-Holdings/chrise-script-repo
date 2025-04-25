# Install Powershell Tech Tools (and Notepad++)
#Run as Admin

# Allow Me to Use My Tools
set-executionpolicy remotesigned -force

#Allow Me to Install My Tools
set-psrepository PSGallery -InstallationPolicy Trusted

#Install PS Module Dependancies
Install-PackageProvider -Name NuGet -Force

#Gimme My Tools
install-module az -force
install-module pswindowsupdate -force
install-module exchangeonlinemanagement -force
Install-Module MSOnline -force
install-module Microsoft.Online.SharePoint.PowerShell -force
install-module Microsoft.graph -force
Install-Module PnP.PowerShell -force
Install-Module AzureAD -force

#For Good Measure - Update all Installed Modules
Update-Module -force

#Update All Winget-Supported Packages and accept agreements
winget upgrade --all --accept-package-agreements --accept-source-agreements

#Install Notepad++
winget install notepad++

#Install 7Zip
winget install 7zip

#Install Adobe Reader
winget install --id=Adobe.Acrobat.Reader.64-bit  -e

#Install Browsers
Winget install mozilla.firefox
winget install --id=Google.Chrome  -e

#Install Visual Studio Community
winget install --id=Microsoft.VisualStudio.2022.Community  -e
