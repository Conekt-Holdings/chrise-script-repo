Foreach ($PSPath in Get-ChildItem -path Registry::HKEY_USERS) {

$Path = "$PSPath\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
 
New-ItemProperty -Path Registry::$Path -Name Autodetect -Type Dword -Value 0 -Force
Set-ItemProperty -Path Registry::$Path -Name Autodetect -Type Dword -Value 0 -Force

}
