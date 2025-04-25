function Block-AddShortcutsToOneDrive {
[SkyKickCommand(DisplayName = "CBX - Block adding SPO shortcuts to OneDrive (Select customers to run on)")]

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
		$SPOShortcut = Set-SPOTenant -DisableAddShortCutsToOneDrive $True
		# Filtering for legacy client apps only
		Write-Host "`n"
		Write-Host "Blocking Add to shortcut option in SPO for customer: $CustomerName" -BackgroundColor White -ForegroundColor DarkBlue
		Write-Host ""
		Write-Output $SPOShortcut
		Set-PnPTenant -DisableAddToOneDrive $True
}
}
