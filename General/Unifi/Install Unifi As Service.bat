rem # Uninstall Service
cd "%UserProfile%\Ubiquiti UniFi\"
java -jar lib\ace.jar uninstallsvc
rem # Re-Install and Start Service
java -jar lib\ace.jar installsvc
java -jar lib\ace.jar startsvc

rem # as per https://help.ui.com/hc/en-us/articles/205144550-Self-Hosting-a-UniFi-Network-Server-as-a-Windows-Service-Advanced

rem # If you do received an error stating that a reg path could not be found, or that some java dll files could not be found, you may need to install the service as per below:
rem # This is relevant if using Adoptium 17
rem # cd "%UserProfile%\Ubiquiti UniFi\"
rem # "C:\Program Files\Eclipse Adoptium\jre-17.0.17.10-hotspot\bin\Java.exe" -jar lib\ace.jar uninstallsvc
rem # "C:\Program Files\Eclipse Adoptium\jre-17.0.17.10-hotspot\bin\Java.exe" -jar lib\ace.jar installsvc
rem # "C:\Program Files\Eclipse Adoptium\jre-17.0.17.10-hotspot\bin\Java.exe" -jar lib\ace.jar startsvc