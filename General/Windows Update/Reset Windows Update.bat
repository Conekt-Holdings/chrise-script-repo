@REM This Completely Resets Windows Updates

@REM This Runs twice as the Windows Update service tends to restart while the delete is running, causing "access denied" errors
net stop wuauserv
del C:\Windows\SoftwareDistribution /Q /S
net stop wuauserv
del C:\Windows\SoftwareDistribution /Q /S
net start wuauserv

@rem Runs Windows Updates and Reset Windows Update Cookie(Pre-Windows 10)
wuauclt /detectnow /resetauthorization /updatenow
@rem Run Windows Updates (Windows 10, Server 2016)
USOClient scaninstallwait
