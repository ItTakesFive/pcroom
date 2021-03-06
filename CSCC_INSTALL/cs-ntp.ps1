#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-ntp {

    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-NTP Parameters..."

    # 每12hr sync ntp
    #FIXME No work!
    net start w32time 
    w32tm /config /update /manualpeerlist:time.nist.gov
    w32tm /resync
    net stop w32time  
    net start w32time
    Set-Service w32time -startuptype automatic
    $path = 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient'
    $str = @("time.nist.gov","0")
    Set-ItemProperty $path -name 'SpecialPollTimeRemaining' -value $str -Type "MultiString"
    Set-ItemProperty $path -name 'SpecialPollInterval' -value '43200' -Type "DWord"
    
    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-NTP Completed..."
}	
