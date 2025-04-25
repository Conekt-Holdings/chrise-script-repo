# Uninstall Service
cd "%UserProfile%\Ubiquiti UniFi\"
java -jar lib\ace.jar uninstallsvc
# Re-Install and Start Service
java -jar lib\ace.jar installsvc
java -jar lib\ace.jar startsvc

# as per https://help.ui.com/hc/en-us/articles/205144550-Self-Hosting-a-UniFi-Network-Server-as-a-Windows-Service-Advanced
