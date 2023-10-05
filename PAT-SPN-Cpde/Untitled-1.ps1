Install-Module -Name Az -Confirm:$False -Force -AllowClobber
Import-Module Az
$username = "useremail"
$password = "password"
$SecurePassword = ConvertTo-SecureString "$password" -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($username, $SecurePassword)
Connect-AzAccount -Credential $credentials -TenantId yourTenantID

$token = (Get-AzAccessToken -ResourceUrl "499b84ac-1321-427f-aa17-267ca6975798").Token

$URL = 'https://dev.azure.com/{orgname}/{Projectname}/_apis/pipelines/{pipelineID}/runs?api-version=6.0-preview.1'
$header = @{
    'Authorization' = 'Bearer ' + $token
    'Content-Type' = 'application/json'
}
$body = @"
  {
    "resources": {
        "repositories": {
            "self": {
                "refName": "refs/heads/master"
            }
        }
    }
  }
"@

Invoke-RestMethod -Method Post -Uri $URL -Headers $header -Body $body