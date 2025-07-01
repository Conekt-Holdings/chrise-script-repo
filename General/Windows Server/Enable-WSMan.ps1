If (!(Test-Path C:\WSMANCresSSPEnabbled.txt)) {
    Enable-WSManCredSSP -Role Client -DelegateComputer '*.domain.tld' -Force
    New-Item C:\WSMANCresSSPEnabbled.txt -Force
    Set-Content C:\WSMANCresSSPEnabbled.txt 'WSMan has been enabled with CredSSP Support' -Force
}
else {
    Write-Output 'WinRM Delegation Already Enabled'
    Exit 0
}
