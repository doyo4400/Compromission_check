# Compromission_check

Little script for quick view if you are compromised by bot

* Get-NetTCPConnection for view : 
  * Remote IP 
  * Property of the IP with ipinfo.net 
  * Associate program
* User(s) connected
* Account in localgroup Administrators


# To do for futur :
* add autoruns.exe : https://live.sysinternals.com/autoruns.exe for check unknow publisher

* Add a file with hash of task scheduler for compare
OR
* Get-ScheduledTask | Where-Object {$_.State -match 'Ready'} 

Windows
>  netstat -afb

Linux
> sudo netstat -lnp
