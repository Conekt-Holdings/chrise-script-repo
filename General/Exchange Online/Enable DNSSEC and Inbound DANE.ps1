#Don't run this as is, just here as a reminder.
Enable-DnssecForVerifiedDomain $Domain
Enable-SmtpDaneInbound -DomainName $Domain
