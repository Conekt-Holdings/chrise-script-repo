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

#Install Google Chrome
if (Resolve-Path "C:\Program Files\Google\Chrome\Application\Chrome.exe") {
    Write-Host Google Chrome is Installed
}
Else {
    Write-Host Google Chrome is not installed, proceeding with installation
    .\winget.exe install --id=Google.Chrome -e --accept-package-agreements --accept-source-agreements
}

#Install Firefox
if (Resolve-Path "C:\Program Files\Mozilla Firefox\firefox.exe") {
    Write-Host Mozilla Firefox is Installed
}
Else {
    Write-Host Firefox is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id Mozilla.Firefox --accept-package-agreements --accept-source-agreements
}

#Install Forticlient
if (Resolve-Path "C:\Program Files\Fortinet\FortiClient\forticlient.exe") {
    Write-Host Forticlient is Installed
}
Else {
    Write-Host Forticlient is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id Fortinet.FortiClientVPN --accept-package-agreements --accept-source-agreements
}

#Install Office
if (Resolve-Path "C:\Program Files\Microsoft Office\root\Office16\EXCEL.exe") {
    Write-Host Office is Installed
}
Else {
    Write-Host Office is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id Microsoft.Office --accept-package-agreements --accept-source-agreements
}

#Install WinRAR
if (Resolve-Path "C:\Program Files\WinRAR\winrar.exe") {
    Write-Host WinRAR is Installed
}
Else {
    Write-Host WinRAR is Not Installed, Proceeding with Installation
	.\winget.exe install --id=RARLab.WinRAR -e --accept-package-agreements --accept-source-agreements
}

#Install Google Earth
if (Resolve-Path "C:\Program Files\Google\Google Earth Pro\client\googleearth.exe") {
    Write-Host Google Earth is Installed
}
Else {
    Write-Host Google Earth is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id Google.EarthPro --accept-package-agreements --accept-source-agreements
}

#Install VLC
if (Resolve-Path "C:\Program Files\VideoLAN\VLC\vlc.exe") {
    Write-Host VLC is Installed
}
Else {
    Write-Host VLC is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id VideoLAN.VLC --accept-package-agreements --accept-source-agreements
}

#Install Cute PDF Writer
if (Resolve-Path "C:\Program Files (x86)\CutePDF Writer\CutePDFWriter.exe") {
    Write-Host Cute PDF Writer
}
Else {
    Write-Host Cute PDF Writer is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id AcroSoftware.CutePDFWriter --accept-package-agreements --accept-source-agreements
}

#Install PDF Creator
if (Resolve-Path "C:\Program Files\PDFCreator\PDFCreator.exe") {
    Write-Host PDF Creator is Installed
}
Else {
    Write-Host PDF Creator is Not Installed, Proceeding with Installation
	.\winget.exe install -e --id Avanquestpdfforge.PDFCreator-Free --accept-package-agreements --accept-source-agreements
}
