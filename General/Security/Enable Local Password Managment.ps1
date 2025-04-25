New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd' -Name 'AdmPwdEnabled' -Value '1' -Force
