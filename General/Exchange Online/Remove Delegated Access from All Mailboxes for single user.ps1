Connect-ExchangeOnline
$exuser='christopher@cloudboxtech.com'
$mailboxes=Get-Mailbox 
$mailboxes | foreach {Remove-MailboxPermission -Identity  $_.UserPrincipalName -user $exuser -AccessRights FullAccess -Confirm:$False -BypassMasterAccountSid}
$mailboxes | foreach {Remove-MailboxPermission -Identity  $_.UserPrincipalName -user $exuser -AccessRights SendAs -Confirm:$False -BypassMasterAccountSid}
$mailboxes | foreach {Remove-RecipientPermission -Identity  $_.UserPrincipalName -AccessRights SendAs -Trustee $exuser -Confirm:$False}
$mailboxes | foreach {Remove-RecipientPermission -Identity  $_.UserPrincipalName -AccessRights FullAccess -Trustee $exuser -Confirm:$False}
$mailboxes | ForEach {Remove-MailboxFolderPermission -Identity "$($_.PrimarySMTPAddress):\Calendar" -User $exuser -Confirm:$False}
