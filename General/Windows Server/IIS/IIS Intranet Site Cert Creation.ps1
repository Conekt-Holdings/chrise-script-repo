#Root Cert and allocation of root cert to $Cert variable
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=OCSRootCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

#Child Cert creation using $cert variable for root cert
New-SelfSignedCertificate -Type Custom -DnsName jenkins.oceanwood.com -KeySpec Signature `
-Subject "CN=jenkins.oceanwood.com" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert

New-SelfSignedCertificate -Type Custom -DnsName internal.oceanwood.com -KeySpec Signature `
-Subject "CN=internal.oceanwood.com" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert
