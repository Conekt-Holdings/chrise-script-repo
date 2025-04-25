$sys = Get-WmiObject Win32_Computersystem -EnableAllPrivileges
$sys.AutomaticManagedPagefile = $true
$sys.put()
