Connect-ExchangeOnline

# Get all mailboxes
$Mailboxes = Get-Mailbox -ResultSize Unlimited

# Loop through each mailbox
foreach ($Mailbox in $Mailboxes) {

    # Search for specified SMTP address in every mailbox
    $SMTPAddress = $Mailbox.EmailAddresses | Where-Object { $_ -like "*@cloudbox.tech" }
      
    # Do nothing when there is already an SMTP address configured
    If (($SMTPAddress | Measure-Object).Count -eq 0) {
	
        $Address = "$($Mailbox.Alias)@cloudbox.tech"

        Set-Mailbox $Mailbox.DistinguishedName -EmailAddresses @{add = $Address }

        # Write output
        Write-Host "Adding $($Address) to $($Mailbox.Name) Mailbox" -ForegroundColor Green
    }
}

# Get all Groups
$Groups = Get-UnifiedGroup -ResultSize Unlimited

# Loop through each group
foreach ($Group in $Groups) {

    # Search for specified SMTP address in every group
    $SMTPAddress = $Group.EmailAddresses | Where-Object { $_ -like "*@cloudbox.tech" }
      
    # Do nothing when there is already an SMTP address configured
    If (($SMTPAddress | Measure-Object).Count -eq 0) {
	
        $Address = "$($Group.Alias)@cloudbox.tech"

        Set-UnifiedGroup -Identity $Group.DistinguishedName -EmailAddresses @{add = $Address }

        # Write output
        Write-Host "Adding $($Address) to $($Group.Name) Group" -ForegroundColor Green
    }
}
