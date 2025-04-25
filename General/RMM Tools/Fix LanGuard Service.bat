rem # Fix GFI LanGuard 11 Issue
rem # Revision 2 - Checks whether LanGuard is installed and reports error if not.

:Architecture Check
rem # Checks whether files exist and which program files folder they are installed in.
if exist "C:\Program Files\Advanced Monitoring Agent\patchman\11\lnssatt.exe" (goto x64) else goto x86Test
@exit

:x86Test
if exist "C:\Program Files (x86)\Advanced Monitoring Agent\patchman\11\lnssatt.exe" (goto x86) else goto NotInstalled
@exit

:x86
sc create gfi_lanss11_attservice start= auto binPath= "C:\Program Files (x86)\Advanced Monitoring Agent\patchman\11\lnssatt.exe -service" displayName= "GFI LanGuard 11 Attendant Service"
goto ServStart
@exit

:x64
sc create gfi_lanss11_attservice start= auto binPath= "C:\Program Files\Advanced Monitoring Agent\patchman\11\lnssatt.exe -service" displayName= "GFI LanGuard 11 Attendant Service"
goto ServStart
@exit

:ServStart
net start "GFI LanGuard 11 Attendant Service"
@exit

:NotInstalled
@cls
@echo Service is not installed, please install MSP Agent
@pause
@exit
