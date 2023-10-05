$token = (Get-AzAccessToken -ResourceUrl "499b84ac-1321-427f-aa17-267ca6975798").Token
$URL = 'https://dev.azure.com/orgname/testpro1/_apis/pipelines/52/runs?api-version=6.0-preview.1'
$header = @ {  'Authorization' = 'Bearer ' + $token  'Content-Type' = 'application/json' }
$body = @\"  {  \"resources\": {  \"repositories\": {  \"self\": {  \"refName\": \"refs/heads/main\"  }  }  }  } \"@
Invoke-RestMethod -Method Post -Uri $URL -Headers $header -Body $body | ConvertTo-Json