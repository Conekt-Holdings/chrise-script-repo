rem # Fix Library Not Registered Issues
rem # This should be the windows .net path
cd C:\Windows\Microsoft.NET\Framework\v4.0.30139\
regtlibv12.exe activeds.tlb

regsvr32 mmcndmgr.dll
regsvr32 jscript.dll
regsvr32 vbscript.dll
