#--------------------------------------------------------------------------------- 
#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

#requires -Version 2.0

#Adds active directory modules to the current session
Import-Module -Name ActiveDirectory

Function Get-OSCADObjectOU
{
<#
 	.SYNOPSIS
        Get-OSCADObjectOU is an advanced function which can be used to display what OU the objects belong to.
    .DESCRIPTION
        Get-OSCADObjectOU is an advanced function which can be used to display what OU the objects belong to.
    .PARAMETER  <ADObject>
		Specifies the account name you want to search.
	.PARAMETER  <ADObjectLists>
		Specifies list of account name you want to import.
    .PARAMETER  <Server>
		Specifies the servers on which the command runs.
	.PARAMETER  <Credential>
		Specifies a user account that has permission to perform this action. 
    .EXAMPLE
        C:\PS> Get-OSCADObjectOU -ADObject "Test001"
		
		Name            ObjectClass     Organizational Unit
		----            -----------     -------------------
		Test001          user            OU=Sub Market OU=Market
		
	.EXAMPLE 
        C:\PS> Get-OSCADObjectOU -ADObjectLists C:\List.txt	
	
		Name                ObjectClass     Organizational Unit
		----                -----------     -------------------
		Mary Lisa           user            OU=Market
		Administrator       user            Default Container
		James               user            OU=Sub Market OU=Market
	.EXAMPLE 
		C:\PS> $cre = Get-Credential
        C:\PS> Get-OSCADObjectOU -ADObjectLists C:\List.txt	-Server WSD.MSTEST.COM -Credential $cre
	
		Name                ObjectClass     Organizational Unit
		----                -----------     -------------------
		Mary Lisa           user            OU=Market
		Administrator       user            Default Container
		James               user            OU=Sub Market OU=Market
#>
	[CmdletBinding(SupportsShouldProcess=$true,DefaultParameterSetName="AccountName")]
	Param
	(
		[Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true,ParameterSetName='AccountName')]
		[Alias('adn')][String[]]$ADObject,
		[Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true,ParameterSetName='ListPath')]
		[Alias('adl')][String]$ADObjectLists,
		[Parameter(Mandatory=$false,Position=1)]
		[String]$Server,
		[Parameter(Mandatory=$false,Position=2)]
		[Alias('Cred')][System.Management.Automation.PsCredential]$Credential
	)
	
	If($Server -and $Credential)
	{
		if($ADObject)
		{
			foreach($Object in $ADObject)
			{
				ADAccountInfo -Object $Object -Server $Server -Credential $Credential
			}
		}
		if($ADObjectLists)
		{
			if(Test-Path $ADObjectLists)
			{
				foreach($Object in (Get-Content -Path $ADObjectLists))
				{
					ADAccountInfo -Object $Object -Server $Server -Credential $Credential
				}
			}
			else
			{
				Write-Warning "The path does not exist, plese input the correct path."
			}
		}
	}
	else
	{
		if($ADObject)
		{
			foreach($Object in $ADObject)
			{
				ADAccountInfo($Object)
			}
		}
		if($ADObjectLists)
		{
			if(Test-Path $ADObjectLists)
			{
				foreach($Object in (Get-Content -Path $ADObjectLists))
				{
					ADAccountInfo($Object)
				}
			}
			else
			{
				Write-Warning "The path does not exist, plese input the correct path."
			}
		}
	}
}

Function ADAccountInfo
{
	param
	(
		$Object,$Server,$Credential
	)
	If($Server -and $Credential)
	{
		$ObjectInfo = Get-ADObject -Filter 'Name -like $Object' -Server $Server -Credential $Credential| Select-Object Name, ObjectClass, `
		@{Expression={$NewDistinguishedName = ($_.DistinguishedName).split(",")| `
		Select-String -CaseSensitive -Pattern "OU=";if($NewDistinguishedName -eq $null)
													{"(Default Container)"}
													else
													{@($NewDistinguishedName|Foreach{$_.Line})[0].Replace("OU=","")}};Label="Organizational Unit"}
        if($ObjectInfo -eq $null)
        {
            $myobject = "" | Select-Object Name, ObjectClass, "Organizational Unit"
            $myobject.Name = "$Object"
            $myobject.ObjectClass = "Not Found"
            $myobject."Organizational Unit" = "Not Found"
            
            $ObjectInfo+=$myobject
            $ObjectInfo
        }
        Else
        {
            $ObjectInfo
        }
	}
	Else
	{
		$ObjectInfo = Get-ADObject -Filter 'Name -like $Object'| Select-Object Name, ObjectClass, `
		@{Expression={$NewDistinguishedName = ($_.DistinguishedName).split(",")| `
		Select-String -CaseSensitive -Pattern "OU=";if($NewDistinguishedName -eq $null)
													{"(Default Container)"}
													else
													{@($NewDistinguishedName|Foreach{$_.Line})[0].Replace("OU=","")}};Label="Organizational Unit"}
        if($ObjectInfo -eq $null)
        {
            $myobject = "" | Select-Object Name, ObjectClass, "Organizational Unit"
            $myobject.Name = "$Object"
            $myobject.ObjectClass = "Not Found"
            $myobject."Organizational Unit" = "Not Found"
            
            $ObjectInfo+=$myobject
            $ObjectInfo
        }
        Else
        {
            $ObjectInfo
        }
	}
}
