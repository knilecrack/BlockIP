$securityLogs = Get-WinEvent -FilterHashTable @{LogName='Security';ID='4625'} -MaxEvents 100
[string[]]$arrayOfIps = @()


foreach ($log in $securityLogs) {
  $messageFromLog = $log.Message
  $ip = $messageFromLog | Select-String -Pattern "\s+\d{1,3}(\.\d{1,3}){3}" -AllMatches | Select-Object -ExpandProperty matches | Select-Object -ExpandProperty value
  $ip = $ip.Trim()
  if($arrayOfIps.IndexOf($ip) -eq -1) {
    $arrayOfIps += $ip
  }
}


New-NetFirewallRule -DisplayName "BlockRule2" -Direction Inbound -LocalPort Any -Protocol any -Action Block -RemoteAddress 185.156.177.42
$gc = Get-NetFirewallRule -Name "{14b145ab-a08a-4b09-a9ea-d9752cd49658}" | Get-NetFirewallAddressFilter
$gc.RemoteAddress
#TODO: add logs
#function to add added IP addresses to txt.log

#TODO:
#connect to mikrotik and add IP address as blacklist
