#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-ntp {

    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-NTP Parameters..."

    # 每12hr sync ntp
    #FIXME No work!
    Set-Service w32time -startuptype automatic
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient' -name 'SpecialPollTimeRemaining' -value 'tntserv.cs.nctu.edu.tw,0' -Type "MultiString"
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient' -name 'SpecialPollInterval' -value '43200' -Type "DWord"
    net start w32time 
    w32tm /config /update /manualpeerlist:time.nist.gov
    w32tm /resync
    net stop w32time  
    net start w32time 

    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-NTP Completed..."
}	
