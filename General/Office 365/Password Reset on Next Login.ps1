Connect-MgGraph -Scopes Directory.AccessAsUser.All

$PasswordProfile = @{
   ForceChangePasswordNextSignIn = $true
 }
 
Update-MgUser -userid user@domain.com -PasswordProfile $PasswordProfile
