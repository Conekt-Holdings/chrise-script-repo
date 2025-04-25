REG QUERY HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System /v CleanupProfiles | findstr 0x5a
IF %errorlevel%==0 GOTO exist
IF %errorlevel%==1 GOTO no_exist
:exist
@echo reg key does exist
@exit 0
:no_exist
@echo reg key does not exist
@exit 1
