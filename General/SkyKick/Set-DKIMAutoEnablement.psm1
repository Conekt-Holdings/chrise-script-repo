function Set-DKIMAutoEnablement {
[SkyKickCommand(DisplayName = "CBX - Auto Rotate DKIM keys to 2048bit (Select Customer to run on)")]
param(
[Parameter(Mandatory=$true)][CustomerContext[]]$SelectCustomers
)

# Begin processing selected customers
	# ===================================
	$SortedCustomers = Sort-Object -Property Customername -InputObject $SelectCustomers
	ForEach ($Customer in $SortedCustomers){
		Set-CustomerContext $Customer
		$CustomerInfo = Get-CustomerContext
		$CustomerName = $CustomerInfo.CustomerName

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
