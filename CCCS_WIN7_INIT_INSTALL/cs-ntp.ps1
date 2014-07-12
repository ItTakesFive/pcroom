#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-ntp {

    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-NTP Parameters..."

    # 每12hr sync ntp
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient' -name 'SpecialPollTimeRemaining' -value 'ntserv.cs.nctu.edu.tw,0' -Type "MultiString"
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient' -name 'SpecialPollInterval' -value '43200' -Type "DWord"
    Set-ItemProperty 'HKLM:\SYSTEM\State\Clock' -name 'NetworkTimeSync' -value '1' -Type "DWord"
    w32tm /resync /nowait
    #net stop w32time  
    #net start w32time 

    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-NTP Completed..."
}