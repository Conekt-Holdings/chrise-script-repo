w32tm /unregister
net stop w32time
w32tm /register
net start w32time
w32tm /config /manualpeerlist:time.windows.com /syncfromflags:manual /reliable:yes /update
net stop w32time
net start w32time
