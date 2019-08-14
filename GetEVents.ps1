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
