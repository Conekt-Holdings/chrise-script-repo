# Steel Eye Metered API Enablement
# Enable Microsoft.GraphServices Resource Provider on Subscription
# Run in Cloud PowerShell Instance
# Swap out AppID and SubScription ID as required, target resource group must exist before running this.

az resource create --resource-group SteelEye --name SteelEyeAppBilling --resource-type Microsoft.GraphServices/accounts --properties  "{`"appId`": `"f7f246a4-1fc4-4bc4-a865-624ce7d29428`"}" --location Global --subscription bbfd0737-2b60-43f6-a2a5-331dd8df64c4
