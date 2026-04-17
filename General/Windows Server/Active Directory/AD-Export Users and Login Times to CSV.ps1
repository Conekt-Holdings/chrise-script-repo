<#
.SYNOPSIS
    Export all AD user accounts with their last login date to a CSV file.

.DESCRIPTION
    This script retrieves all enabled Active Directory user accounts,
    fetches their last logon timestamp, and exports the data to a CSV file.
    It uses the LastLogonDate property, which is replicated across domain controllers.

.NOTES
    Requires: ActiveDirectory PowerShell module
    Run as: Domain Admin or with read access to AD
#>

# Ensure the Active Directory module is loaded
Import-Module ActiveDirectory -ErrorAction Stop

try {
    # Retrieve all enabled users with their last logon date
    $users = Get-ADUser -Filter * `
        -Properties DisplayName, SamAccountName, LastLogonDate, LastLogonTimeStamp, Enabled |
        Select-Object DisplayName,
                      SamAccountName,
					  Enabled,
                      @{Name="LastLogonDate"; Expression = { $_.LastLogonDate -as [datetime] }},
					  @{Name="LastLogonTimeStamp"; Expression = { $_.LastLogonTimeStamp -as [datetime] }}

    # Define output file path
    $outputPath = "C:\Temp\AD_Users_LastLogin.csv"

    # Export to CSV
    $users | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

    Write-Host "Export completed successfully. File saved to: $outputPath" -ForegroundColor Green
}
catch {
    Write-Error "An error occurred: $_"
}