Connect-ExchangeOnline
Get-Mailbox | Enable-Mailbox -Archive
Set-OrganizationConfig -AutoExpandingArchive
Get-Mailbox | Enable-Mailbox -AutoExpandingArchive
