# WSUS - Upgrade Fix
# Disable Upgrades Classification
Get-WsusClassification | Where-Object -FilterScript {$_.Classification.Title -Eq “Upgrades”} | Set-WsusClassification -Disable
# Delete Upgrades 
$s = Get-WsusServer
$s.SearchUpdates(“version 1511, 10586”) | foreach { $s.DeleteUpdate($_.Id.UpdateId) } 
# Enable Upgrades Classification
Get-WsusClassification | Where-Object -FilterScript {$_.Classification.Title -Eq “Upgrades”} | Set-WsusClassification 
#Start Sync
$sub = $s.GetSubscription()
$sub.StartSynchronization()
