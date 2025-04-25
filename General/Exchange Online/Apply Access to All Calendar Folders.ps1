connect-exchangeonline

Get-Mailbox -ResultSize Unlimited | ForEach {Add-MailboxFolderPermission -Identity "$($_.PrimarySMTPAddress):\Calendar" -User "Simona Griniute" -AccessRights Editor }
