# Requires Posh-SSH. PS> Install-Module -Name Posh-SSH -RequiredVersion 2.0.2
$server = 'codeguidelines.hta.cloud'
$remoteFolder = '/var/www'
$localFolder = '_site'

# Create a credentials file with get-credentials | Export-clixml -path .\servercred.xml
$credentials = Import-Clixml -Path '.\ServerCred.xml'
$session = New-SSHSession -ComputerName $server -Credential $credentials -AcceptKey
$null = Invoke-SSHCommand -SSHSession $session -Command "rm -rf $remoteFolder/*"
Set-SCPFolder -ComputerName $server -Credential $credentials -AcceptKey -LocalFolder $localFolder -RemoteFolder "$remoteFolder"
$null = Invoke-SSHCommand -SSHSession $session -Command "chmod -R 755 $remoteFolder/."
Remove-SSHSession -SSHSession $session