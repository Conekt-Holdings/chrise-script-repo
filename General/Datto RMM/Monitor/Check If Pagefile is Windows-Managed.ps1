$ComputerSystem = Get-WmiObject -ClassName Win32_ComputerSystem

if ($ComputerSystem.AutomaticManagedPageFile -match "true") {
  echo "Pagefile setting correct "$ComputerSystem.AutomaticManagedPageFile""
  exit 0
} else {
  
  echo "Pagefile setting incorrect "$ComputerSystem.AutomaticManagedPageFile""
  exit 1
}
