foreach ($Id in Get-AZSubscription)
{
	Set-AZContext $Id
	Register-AzProviderFeature -FeatureName "EncryptionAtHost" -ProviderNamespace "Microsoft.Compute"
}	