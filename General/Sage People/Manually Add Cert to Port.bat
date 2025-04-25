rem Example - Do Not Use, read notes
netsh http show sslcert
rem confirm app ID for service running on port 9443 and use it below
rem cert should be in machine personal store, and should have a private key
netsh http delete sslcert 0.0.0.0:9443
netsh http add sslcert ipport=0.0.0.0:9443 certhash=4e417b72852a22534a6d70fb2928eb6f7000f7e6 appid={27eaacdb-40ed-4710-95b8-9d60a96471a9}
