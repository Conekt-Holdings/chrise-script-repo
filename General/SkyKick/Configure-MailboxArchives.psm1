function Start-EnableMailboxArchives {
[SkyKickCommand(DisplayName = "CBX - Enable Mailbox Archiving on All Mailboxes (Select Customer to run on)")]
param(
[Parameter(Mandatory=$true)][CustomerContext[]]$SelectCustomers
)

# Begin processing selected customers
	# ===================================
	$SortedCustomers = Sort-Object -Property Customername -InputObject $SelectCustomers
	ForEach ($Customer in $SortedCustomers){
		Set-CustomerContext $Customer

Get-Mailbox | Enable-Mailbox -Archive
Set-OrganizationConfig -AutoExpandingArchive
Get-Mailbox | Enable-Mailbox -AutoExpandingArchive

}
}
