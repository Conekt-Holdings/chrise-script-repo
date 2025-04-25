# Global Cleanup

# Windows Update Temp Files
# NOTE - Runs Twice, as service tends to restart during operation
Stop-Service -name "Wuauserv"
del C:\Windows\SoftwareDistribution\* -Recurse
Start-Service -name "Wuauserv"
Stop-Service -name "Wuauserv"
del C:\Windows\SoftwareDistribution\* -Recurse
Start-Service -name "Wuauserv"
#Clear Windows Temp Folder
del C:\Windows\Temp\* -Recurse
# Old Windows Component Store Items
dism /online /cleanup-image /startcomponentcleanup /resetbase
# Cleanup INETPUB Logs
del C:\inetpub\logs\* -Recurse
# List All User Folders and store in "folder" array
cd C:\Users
foreach ($folder in Get-ChildItem)
{
# Clear Appdata\Local\Temp
del $folder\appdata\local\temp\* -Recurse
# Clear old SCANPST Backup Files
del $folder\appdata\local\microsoft\outlook\*.bak
}

####################################################
#
# ONEDRIVE - FREE UP SPACE SCRIPT
#
####################################################


<#
	.SYNOPSIS
	This script will remove the local version of any OneDrive file with certain attributes
	.DESCRIPTION
	The script will look for files with certain attributes and clean them from the device in an attempt to free-up space on the device.
	.NOTES
	VERSION: 1.3.1a
	PREREQ: N/A
    AUTHOR: Radu Costandache
#>

####################################################
#
# CONFIG & EXECUTION
#
####################################################
#
# Attributes -eq '525344'                == is for user set "always keep"
#
# Attributes -eq 'Archive, ReparsePoint' == is for regular file that is downloaded but can be cleared
#
####################################################
#
# Use the Attributes in the comments above and change them below if you want to target a specific group.
# Otherwise, remove the "where Attributes" section alltogether.
#
####################################################

    $attributes = 'Archive, ReparsePoint'

    # Get all user profiles matching the correct description
    $userFolders = Get-ChildItem "C:\Users" | where {$_.name -notmatch 'Public|default'}

####################################################
#
# FUNCTIONS
#
####################################################

Function FatalError {

    <#
    .SYNOPSIS
		This function will output mostly readable error information for web request related errors.
		.DESCRIPTION
		Unwraps most of the exeption details and gets the response codes from the web request, afterwards it stops script execution.
		.NOTES
		NAME: FatalWebError
    #>

    param
    (
        [Parameter(Mandatory=$true)]
        $Exeption, # Should be the execption trace, maybe try $_.Exception
        [Parameter(Mandatory=$true)]
        $Function # Name of the function that calls this function (for readability)
    )

        #Handles errors for all the Try/Catch cases

        $errorResponse = $Exeption.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorResponse)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $responseBody = $reader.ReadToEnd();
        Write-Host "Failed to execute Function : $Function" -f Red
        Write-Host "Response content:`n$responseBody" -f Red
        Write-Host "Request to $Uri failed with HTTP Status $($Exeption.Response.StatusCode) $($Exeption.Response.StatusDescription)" -f Red
        write-host
        break

}

####################################################

Function Clean-OneDrive {

    <#
		.SYNOPSIS
		This function will cleanup the private OneDrive folders
		.DESCRIPTION
		The function checks against names matching "OneDrive - " format and clean any local files, keeping the online version
		.NOTES
		NAME: Clean-OneDrive
    #>

    try {

        Write-Output "Cleaning OneDrive files..."

        foreach ($user in $userFolders) {

            # For each user matching the right Attributes, cleanup the files
            Get-ChildItem -Path C:\Users\$user'\OneDrive - *' -Recurse  | where Attributes -eq $attributes | foreach {
    
                #Changes the attribute to clear it from the local device but keep in the cloud
                attrib.exe $_.fullname +U -P /s

                #Write which file it's cleaning.
                Write-Output "File $_. has been cleaned"

            }

        }

    } catch {

        FatalError -Exeption $_.Exception -Function "Clean-OneDrive"

    }

}

####################################################

Function Clean-SharePoint {

    <#
		.SYNOPSIS
		This function will cleanup the company SharePoint synced locally folders
		.DESCRIPTION
		The function checks against names matching "OneDrive - *" format and extracts the SPO site name, then cleans the local files in there, keeping the online version
		.NOTES
		NAME: Clean-OneDrive
    #>

    try {

        Write-Output "Cleaning SPO files..."

        foreach ($user in $userFolders) {
    
            # Get the Company SPO name from the user path
            $userPath = Get-ChildItem -Path C:\Users\$user'\OneDrive - *'

            # Extract the SPO name
            $userPath_SPO = $userPath.Name -replace "OneDrive - ",""
            #$userPath_SPO

            # For each user matching the right Attributes, cleanup the files
            Get-ChildItem -Path C:\Users\$user\$user2Path_SPO -Recurse  | where Attributes -eq $attributes | foreach {
    
                #Changes the attribute to clear it from the local device but keep in the cloud
                attrib.exe $_.fullname +U -P /s

                #Write which file it's cleaning.
                Write-Output "File $_. has been cleaned"

            }

        }

    } catch {

        FatalError -Exeption $_.Exception -Function "CheckPath"

    }

}

####################################################
#
# EXECUTION
#
####################################################

Clean-OneDrive

Clean-SharePoint

Write-Output "OneDrive and SPO files have been cleaned"

####################################################
#
# Disk Cleanup Script
#
####################################################

<#
	.SYNOPSIS
	This script will create the required registry entries to allow cleanup manager to run silently.
	.DESCRIPTION
	
	.NOTES
	VERSION: 0.3c
	PREREQ: N/A
    AUTHOR: Radu Costandache
#>

####################################################
#
# Functions
#
####################################################

Function FatalError {

    <#
    .SYNOPSIS
		This function will output mostly readable error information for web request related errors.
		.DESCRIPTION
		Unwraps most of the exeption details and gets the response codes from the web request, afterwards it stops script execution.
		.NOTES
		NAME: FatalWebError
    #>

    param
    (
        [Parameter(Mandatory=$true)]
        $Exception, # Should be the execption trace, maybe try $_.Exception
        [Parameter(Mandatory=$true)]
        $Function # Name of the function that calls this function (for readability)
    )

        #Handles errors for all the Try/Catch cases

        $errorResponse = $Exeption.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorResponse)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $responseBody = $reader.ReadToEnd();
        Write-Host "Failed to execute Function : $Function" -f Red
        Write-Host "Response content:`n$responseBody" -f Red
        Write-Host "Request to $Uri failed with HTTP Status $($Exeption.Response.StatusCode) $($Exeption.Response.StatusDescription)" -f Red
        write-host
        break

}

####################################################

Function CreateRegVal() {

    # Create registry values
    $volumeCaches = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"

    try {
        
        Write-Output "Creating new Registry values"

        foreach($key in $volumeCaches){

            New-ItemProperty -Path "$($key.PSPath)" -Name StateFlags0123 -Value 2 -Type DWORD -Force | Out-Null

        }

    } catch {

        FatalError -Exception $_.Exception -Function "CreateRegVal"

    }

}

####################################################

Function CleanDisk() {

    # Execute Disk Cleanup Tool (cleanmgr.exe)

    try {

        Write-Output "Running Disk Cleanup"

        Start-Process -Wait "$env:SystemRoot\System32\cleanmgr.exe" -ArgumentList "/sagerun:123 /verylowdisk"

    } catch {

        FatalError -Exception $_.Exception -Function "CleanDisk"

    }
}

####################################################

Function RemoveRegVal() {
 
    # Remove the previously created registry values
    $volumeCaches = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"

    try {

        Write-Output "Deleting the Registry values"

        foreach($key in $volumeCaches){

            Remove-ItemProperty -Path "$($key.PSPath)" -Name StateFlags0123 -Force | Out-Null

        }

    } catch {

        FatalError -Exception $_.Exception -Function "RemoveRegVal"

    }
}

####################################################
#
# Execution
#
####################################################

CreateRegVal
CleanDisk

Write-Output "Disk cleanup has completed"
#RemoveRegVal

# Run Disk Cleanup with Options to Clear Old Windows Installaton Temp Files (Windows.old)
cleanmgr /autoclean
# Run Disk Cleanup with All Options Checked
cleanmgr /VERYLOWDISK

#Clear System Restore Points
#Disabled - Triggers Sentinal One
#vssadmin delete shadows /For=C: /Oldest /Quiet

# NOT WORKING PROPERLY
# Remove Old Windows Installation Files 
#NOTE 1 DEL portion of command may be able to run on it's own via RMM, still needs to be tested
#NOTE 2 First few steps of command do succesfully grant file access to Windows.old and all subfolders and files, but del portion fails afterwards.
# takeown.exe /f C:\Windows.Old /a
# $CurrentACL = Get-Acl C:\Windows.old
# takeown.exe /f C:\Windows.Old /a /r /d Y
# $AdminACLPermission = "BUILTIN\Administrators", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow"
# SystemAccessRule = new-object System.Security.AccessControl.FileSystemAccessRule $AdminACLPermission
# $CurrentACL.AddAccessRule($SystemAccessRule)
# Set-Acl -Path C:\Windows.Old -AclObject $CurrentACL
# del C:\Windows.old -Recurse

# Clear All Users Recycle Bins
#NOTE 1 seems to fail under user context when run as admin, may succeed in system context
#NOTE 2 Fails under system context as well
# del 'C:\$Recycle.Bin\*' -Recurse
