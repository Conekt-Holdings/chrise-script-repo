@rem CLEAR PRINT SPOOLER
net stop "print spooler"
@echo y | del C:\windows\system32\spool\printers
@netsh winsock reset
@shutdown /r /f /t 0
