Connect-ExchangeOnline

#Enable External Tags in Outlook
Set-ExternalInOutlook –Enabled $true

#Set up external sender Disclaimer (Prepend to emails)
$Disclaimer='<p><div style="background-color:#FFEB9C; width:100%; border-style: solid; border-color:#9C6500; border-width:1pt; padding:2pt; font-size:10pt; line-height:12pt; font-family:Calibri; color:Black; text-align: left;"><span style="color:#9C6500"; font-weight:bold;>CAUTION:</span> This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.</div><br></p>'
New-TransportRule "External Email Warning" -FromScope NotInOrganization -SentToScope InOrganization -Priority 0 -ApplyHtmlDisclaimerText $Disclaimer -ApplyHtmlDisclaimerLocation Prepend -ApplyHtmlDisclaimerFallbackAction Wrap

#Enable External Recipient Warning Mailtip
Set-OrganizationConfig -MailTipsExternalRecipientsTipsEnabled:$True
