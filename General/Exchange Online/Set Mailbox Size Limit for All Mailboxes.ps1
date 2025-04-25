# Connect to Exchange Online
Connect-ExchangeOnline

# Set send / receive limits for all users to 150 MB
Get-Mailbox | Set-Mailbox -MaxSendSize 150mb -MaxReceiveSize 150mb
Get-MailboxPlan | Set-MailboxPlan -MaxSendSize 150mb -MaxReceiveSize 150mb

# Confirm it applied
Get-Mailbox | ft name, maxsendsize, maxreceivesize
Get-MailboxPlan | fl name, MaxSendSize, MaxReceiveSize