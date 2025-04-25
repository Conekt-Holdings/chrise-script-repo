#Create Certs for Use in Azure P2S VPN Configuration
#Uncomment the 2 #-NotAfter entries to make cert valid for 10 years

#Root Cert and allocation of root cert to $Cert variable
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=P2SRootCertSHP" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign #-NotAfter (Get-Date).AddMonths(120)

#Child Cert creation using $cert variable for root cert
New-SelfSignedCertificate -Type Custom -DnsName P2SChildCertSHP -KeySpec Signature `
-Subject "CN=P2SChildCertSHP" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
#-NotAfter (Get-Date).AddMonths(120) `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
