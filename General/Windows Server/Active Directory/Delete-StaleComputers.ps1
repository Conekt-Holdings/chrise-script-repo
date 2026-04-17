$DaysInactive = 180
$time = (Get-Date).Adddays(-($DaysInactive))
Get-ADComputer -Filter {LastLogonDate -lt $time} | Remove-ADObject -Recursive