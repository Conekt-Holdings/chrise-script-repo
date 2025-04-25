rem # this script clears Windows Update's cache and old update files
rem # It can be useful in resolving odd issues with installation of updates
rem # Caveat 1 - This will make the PC think that it has not run updates, and it will need to rescan
rem # Caveat 2 - This will prevent rolling back of Windows Updates
rem # Caveat 3 - The component store cleanup will not run if an update reboot is pending

rem # Stop Windows Update Service and Clear It's Cache
net stop wuauserv
del C:\Windows\SoftwareDistribution /q /s
rem # Run again, as this service has a tendency to restart mid-cleanup
net stop wuauserv
del C:\Windows\SoftwareDistribution /q /s
net start wuauserv

rem # Clear out older versions of Windows system files from the Windows Component Store
dism /online /cleanup-image /startcomponentcleanup /resetbase
