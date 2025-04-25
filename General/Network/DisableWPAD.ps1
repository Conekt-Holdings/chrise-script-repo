Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name 'DisableWpad' -Value 1 -Type 'Dword' -Force
