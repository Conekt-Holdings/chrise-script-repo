get-AzureRmResourceProvider -ListAvailable | foreach-object{Register-AzureRmResourceProvider -ProviderNamespace $_.ProviderNamespace}
