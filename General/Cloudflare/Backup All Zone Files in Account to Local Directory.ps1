function Get-CloudFlareFullZonesConfiguration {
    [CmdletBinding()]
    
    param(
        [Parameter(Mandatory = $true, HelpMessage = 'Provide your CloudFlare API token',
            ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $CloudFlareAPIToken,

        [Parameter(mandatory = $true, HelpMessage = 'Provide your CloudFlare login',
            ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")]
        [string]
        $CloudFlareEmailAddress,

        [Parameter(Mandatory = $true, HelpMessage = 'Provide path for configuration file to read',
            ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( {Test-Path -Path $_ -PathType Container })]
        [string]
        $DestinationFolder
    )
    process {
        #CloudFlare requires TLS 1.2. Setting for this
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		
        #setting CloudFlare Base API url
        $CloudFlareBaseUrl = 'https://api.cloudflare.com/client/v4/zones'

        $CloudFlareHeaders = @{
            'X-Auth-Key'   = $CloudFlareAPIToken
            'X-Auth-Email' = $CloudFlareEmailAddress
        }
    
        #List ALL zones
        $irmZonesProperties = @{
            Uri     = '{0}?per_page=400' -f $CloudFlareBaseUrl
            Method  = 'Get'
            Headers = $CloudFlareHeaders
        }
        $AllZones = Invoke-RestMethod @irmZonesProperties
		
        if ($AllZones.result -eq 'error') {
            throw $($AllZones.msg)
        }
        elseif ($AllZones.success -eq $true) {
            foreach ($zone in $AllZones.result) {
                Write-Verbose "Gathering all information for zone {$($zone.Name)}."
                $ZoneConfiguration = @{
                    ZoneProperties = $zone
                    DNSRecords     = @()
   
                }
                $irmDNSProperties = @{
                    Uri     = '{0}/{1}/dns_records?match=all' -f $CloudFlareBaseUrl, $zone.id
                    Method  = 'Get'
                    Headers = $CloudFlareHeaders
                }
                $zoneIdDNSResult = Invoke-RestMethod @irmDNSProperties
                if ($zoneIdDNSResult.success -eq $true) {
                    $ZoneConfiguration.DNSRecords = $zoneidDNSResult.result
   
                }
                else {
                    Write-Error "There were errors with fetching DNS records for zone {$($zone.Name)} – id {$($zone.id)}"
                }

                $fileName = Join-Path -Path $DestinationFolder -ChildPath ('{0}.json' -f $zone.Name)
                Write-Verbose "Saving configuration for {$($zone.Name)} to file {$fileName}."
                $ZoneConfiguration | ConvertTo-Json | Out-File $fileName
            }
            Write-Verbose "Done processing"
        }
        else {
            Write-Error "There were errors with fetching all zones information with provided login {$CloudFlareEmailAddress}"
        }
    }
}
Get-CloudFlareFullZonesConfiguration
