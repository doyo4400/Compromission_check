Clear-Host

[System.Collections.ArrayList]$list_of_remote_ip = @()
[System.Collections.ArrayList]$list_of_result = @()
$desktop_user_path = "C:\Users\" + [Environment]::UserName + "\Desktop"

$get_connection = Get-NetTCPConnection | Select-Object -Property RemoteAddress, state, @{'Name' = 'ProcessName';'Expression'={(Get-Process -Id $_.OwningProcess).Name}}


#clean for drop IP
$legit_ip_address_to_exclude = "0.0.0.0", "::", "127.0.0.1"

foreach ($ip in $get_connection) {
    if ($ip.RemoteAddress -in $legit_ip_address_to_exclude){
        write-host "local ip : " + $ip.RemoteAddress
        }
     else {
        $list_of_remote_ip.Add($ip)
        }
}

Write-Host "*********** Listing ***********"

foreach ($ip in $list_of_remote_ip){
    $url = "https://ipinfo.io/" +  $ip.RemoteAddress + "/org"
    $page = Invoke-WebRequest -Uri $url    
    $cellule_tab = $(($page.content).Trim()) + "  -  " + $($url) + "  -  " + $($ip.ProcessName)
    Write-Host $cellule_tab
    $list_of_result.Add($cellule_tab)
}





Write-Host "**************************************"
Write-Host "*********** More detailled ***********"
Write-Host "**************************************"

write-host "for mor detail, you can launch on powershell :"
Write-Host " Get-NetTCPConnection | ft -Property LocalAddress, LocalPort, RemoteAddress, RemotePort, state, AppliedSetting, @{'Name' = 'ProcessName';'Expression'={(Get-Process -Id $_.OwningProcess).Name}}"



$result = read-host "Do you wan't a report ? [Y, yes / Other=No]"
 
if (($result -eq "y") -or ($result -eq "yes")){
    $list_of_result | Out-File -Filepath $desktop_user_path
    Write-Host "the report is on your desktop "
}