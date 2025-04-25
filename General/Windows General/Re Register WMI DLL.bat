@echo off
sc config winmgmt start= disabled
net stop winmgmt /y
cd C:\Windows\system32\wbem
FOR %%1 IN (*.DLL) DO REGSVR32 /S %%1
wmiprvse /regserver
winmgmt /salvagerepository
sc config winmgmt start= auto
net start winmgmt
FOR %%1 IN (*.mof) do mofcomp %%1
FOR %%1 IN (*.mfl) do mofcomp %%1
pause
