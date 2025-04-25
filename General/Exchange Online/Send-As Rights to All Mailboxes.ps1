Connect-ExchangeOnline
$mailboxes=Get-Mailbox
$mailboxes | foreach {Add-RecipientPermission -Identity  $_.UserPrincipalName  -AccessRights  SendAs  -Trustee "user@domain.co.za" -Confirm:$False}
