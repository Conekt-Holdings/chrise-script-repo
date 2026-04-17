<#
.SYNOPSIS
    Finds and optionally disables/deletes computer accounts that have not logged in for C days.

.PARAMETER Days
    Number of days since last logon to consider a device stale.

.PARAMETER Delete
    Switch to delete instead of disable (use with caution).

.EXAMPLE
    .\Cleanup-StaleComputers.ps1 -Days 90
    Finds and disables devices not logged in for 90+ days.

.EXAMPLE
    .\Cleanup-StaleComputers.ps1 -Days 180 -Delete
    Finds and deletes devices not logged in for 180+ days.
#>

param (
    [Parameter(Mandatory = $true)]
    [int]$Days,

    [switch]$Delete
)

# Ensure ActiveDirectory module is available
if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Error "ActiveDirectory module not found. Install RSAT tools first."
    exit 1
}

Import-Module ActiveDirectory

try {
    $cutoffDate = (Get-Date).AddDays(-$Days)

    Write-Host "Searching for devices not logged in since $cutoffDate..." -ForegroundColor Cyan

    $staleComputers = Get-ADComputer -Filter { LastLogonDate -lt $cutoffDate -and Enabled -eq $true } `
        -Properties LastLogonDate |
        Sort-Object LastLogonDate

    if (-not $staleComputers) {
        Write-Host "No stale devices found." -ForegroundColor Green
        exit 0
    }

    Write-Host "Found $($staleComputers.Count) stale devices:" -ForegroundColor Yellow
    $staleComputers | Format-Table Name, LastLogonDate

    if ($Delete) {
        # Delete devices
        $staleComputers | ForEach-Object {
            Write-Host "Deleting device: $($_.Name)" -ForegroundColor Red
            Remove-ADComputer -Identity $_ -Confirm:$false
        }
    }
    else {
        # Disable devices (safe mode)
        $staleComputers | ForEach-Object {
            Write-Host "Disabling device: $($_.Name)" -ForegroundColor Magenta
            Disable-ADAccount -Identity $_
        }
    }

    Write-Host "Cleanup complete." -ForegroundColor Green
}
catch {
    Write-Error "Error: $_"
}
