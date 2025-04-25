cd C:\Users
foreach ($folder in Get-ChildItem)
{
del $folder\appdata\roaming\microsoft\signatures\*
}
