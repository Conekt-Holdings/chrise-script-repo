Connect-ExchangeOnline

#Enable DKIM Signing Keys
$DKIMEnablementCNameMissing = Get-DkimSigningConfig  | Where-Object {($_.Enabled -ne $True) -and ($_.Status -eq "CnameMissing")}
Foreach ($Domain in $DKIMEnablementCNameMissing)
	{
		Set-DkimSigningConfig -Identity $Domain -Enabled $True
	}
Clear-Variable -Name "DKIMEnablementCNameMissing"

$DKIMEnablementNotCreated = Get-DkimSigningConfig  | Where-Object {($_.Enabled -ne $True) -and ($_.Status -ne "CnameMissing")}
Foreach ($Domain in $DKIMEnablementNotCreated)
	{
		New-DKIMSigningConfig -Identity $Domain -Enabled $True
	}
Clear-Variable -Name "DKIMEnablementNotCreated"

#Rotate DKIM Signing Keys
$DKIMKey1 = Get-DkimSigningConfig | Where-Object {($_.Selector1KeySize -ne 2048) -and ($_.Enabled -eq $True)}
Foreach ($Domain in $DKIMKey1)
	{
		Rotate-DkimSigningConfig -KeySize 2048 -Identity $Domain
	}
Clear-Variable -Name "DKIMKey1"

$DKIMKey2 = Get-DkimSigningConfig | Where-Object {($_.Selector2KeySize -ne 2048) -and ($_.Enabled -eq $True)}
Foreach ($Domain in $DKIMKey2)
	{
		Rotate-DkimSigningConfig -KeySize 2048 -Identity $Domain
	}
Clear-Variable -Name "DKIMKey2"

#Get All DKIM Domains
Get-DkimSigningConfig | Format-Table Domain, Enabled, Status, Selector1KeySize, Selector2KeySize
}
}
