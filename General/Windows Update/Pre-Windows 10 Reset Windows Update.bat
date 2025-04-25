del C:\Windows\SoftwareDistribution /Q /S
net stop wuauserv
del C:\Windows\SoftwareDistribution /Q /S
net start wuauserv

wuauclt /detectnow /resetauthorization /updatenow
