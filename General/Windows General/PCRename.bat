@echo off
SET LOCAL EnableDelayedExpansion

::Check Computer Name
:name
if %computername:~0,6% == OCS-LON (goto :end) ELSE goto :namechange

:namechange
for /f "tokens=*" %%f in ('wmic bios get serialnumber /value ^| find "="') do set "%%f"
set serialnumber=%serialnumber: =%
SET comp_name=OCS-LON-%serialnumber%
ECHO %comp_name%

WMIC computersystem where name='%computername%' call rename name='%comp_name%'

:end
exit /B 0
