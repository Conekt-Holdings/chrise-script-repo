$hash=(netsh http show sslcert ipport=0.0.0.0:443 | Select-String "Certificate Hash").ToString().Split(":")[1].Trim()
netsh http delete sslcert ip:port
netsh http add sslcert ipport=ip:port certhash="$hash" appid="{APPID}"
net stop service
net start service
