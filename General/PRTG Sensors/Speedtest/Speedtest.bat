:x86orx64
if exist "C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\speedtest-32-v2.0.0-alpha.1-1-gbe80fe4.exe" goto 32bit
if exist "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\speedtest-64-v2.0.0-alpha.1-1-gbe80fe4.exe" goto 64bit
@exit

:32Bit
@ECHO off
taskkill /im speedtest-32-v2.0.0-alpha.1-1-gbe80fe4.exe /f
"C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\speedtest-32-v2.0.0-alpha.1-1-gbe80fe4.exe" > "C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData.txt"
SETLOCAL EnableDelayedExpansion
(
FOR /f "usebackqdelims=" %%g IN ("C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData.txt") DO (
 SET "line=%%g"
 SET "line=!line:.=!"
 ECHO !line!
)
)>"C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"

SET "Ping="
SET "Download="
SET "Upload="
FOR /F "tokens=3" %%A IN ('FINDSTR "Ping" "C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"') DO (
SET Ping=%%A 
)
FOR /F "tokens=3" %%B IN ('FINDSTR "Download" "C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"') DO (
SET Download=%%B 
)
FOR /F "tokens=3" %%C IN ('FINDSTR "Upload" "C:\Program Files\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"') DO (
SET Upload=%%C 
)
goto Output

:64Bit
@ECHO off
taskkill /im speedtest-64-v2.0.0-alpha.1-1-gbe80fe4.exe /f
"C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\speedtest-64-v2.0.0-alpha.1-1-gbe80fe4.exe" > "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData.txt"
SETLOCAL EnableDelayedExpansion
(
FOR /f "usebackqdelims=" %%g IN ("C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData.txt") DO (
 SET "line=%%g"
 SET "line=!line:.=!"
 ECHO !line!
)
)>"C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"

SET "Ping="
SET "Download="
SET "Upload="
FOR /F "tokens=3" %%A IN ('FINDSTR "Ping" "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"') DO (
SET Ping=%%A 
)
FOR /F "tokens=3" %%B IN ('FINDSTR "Download" "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"') DO (
SET Download=%%B 
)
FOR /F "tokens=3" %%C IN ('FINDSTR "Upload" "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\SpeedtestData2.txt"') DO (
SET Upload=%%C 
)
goto Output

:Output
set /a Download1="Download/8"
set /a Upload1="Upload/8"

ECHO ^<^?xml version^=^"1.0^" encoding^=^"UTF-8^" ^?^>
ECHO ^<PRTG^>
ECHO ^<result^>
ECHO ^<Channel^>Ping Latency^</Channel^>
ECHO ^<value^>%Ping%^</value^>
ECHO ^<Mode^>Absolute^</Mode^>
ECHO ^<Unit^>TimeResponse^</Unit^>
ECHO ^<Float^>1^</Float^>
ECHO ^<ShowChart^>1^</ShowChart^>
ECHO ^<ShowTable^>1^</ShowTable^>
ECHO ^</result^>ECHO ^<result^>
ECHO ^<Channel^>Download^</Channel^>
ECHO ^<value^>%Download1%^</value^>
ECHO ^<Mode^>Absolute^</Mode^>
echo ^<volumeSize^>MegaBit^</volumeSize^>
echo ^<float^>0^</float^>
echo ^<unit^>SpeedNet^</unit^>
ECHO ^<ShowChart^>1^</ShowChart^>
ECHO ^<ShowTable^>1^</ShowTable^>
ECHO ^</result^>ECHO ^<result^>
ECHO ^<Channel^>Upload^</Channel^>
ECHO ^<value^>%Upload1%^</value^>
ECHO ^<Mode^>Absolute^</Mode^>
echo ^<volumeSize^>MegaBit^</volumeSize^>
echo ^<float^>0^</float^>
echo ^<unit^>SpeedNet^</unit^>
ECHO ^<ShowChart^>1^</ShowChart^>
ECHO ^<ShowTable^>1^</ShowTable^>
ECHO ^</result^>ECHO ^</PRTG^>
