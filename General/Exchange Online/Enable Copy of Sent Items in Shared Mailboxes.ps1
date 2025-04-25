Connect-ExchangeOnline
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | Set-Mailbox -MessageCopyForSentAsEnabled $true -MessageCopyForSendOnBehalfEnabled $true
