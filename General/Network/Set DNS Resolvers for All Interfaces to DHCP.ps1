# Set DNS Resolvers for All Interfaces to DHCP
ForEach ($name in Get-NetAdapter | select -expand name) {
    netsh interface ipv4 set dnsservers name=$name source=dhcp
    }
