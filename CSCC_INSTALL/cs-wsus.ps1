#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

#Reference: http://support.microsoft.com/kb/328010/zh-tw

Function cs-wsus {

    $WSUS_Server = "http://wsus.cs.nctu.edu.tw:8530"
    $WSUS_StatusServer = $WSUS_Server

    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-WSUS Parameters..."
    if(!( Test-Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' ))
    {
          New-Item 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -force
    }

    #不用有管理員權限的普通用戶也可以接收到更新通知
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -name 'ElevateNonAdmins' -value '1' -propertyType "DWord" -force
    #New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -name 'AcceptTrustedPublisherCerts' -value '1' -propertyType "DWord" -force
    #New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -name 'TargetGroupEnabled' -value '1' -propertyType "DWord" -force
    #New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -name 'TargetGroup' -value $TargetGroup -propertyType "String" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -name 'WUServer' -value $WSUS_Server -propertyType "String" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -name 'WUStatusServer' -value $WSUS_StatusServer -propertyType "String" -force

    if(!( Test-Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' ))
    {
          New-Item 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -force
    }

    #當使用者登入時[自動更新]不會自動重新啟動電腦
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'NoAutoRebootWithLoggedOnUsers' -value '1' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'NoAUShutdownOption' -value '0' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'NoAUAsDefaultShutdownOption' -value '0' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'DetectionFrequencyEnabled' -value '1' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'DetectionFrequency' -value '22' -propertyType "DWord" -force
    #自動安裝
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'AutoInstallMinorUpdates' -value '1' -propertyType "DWord" -force
    #排程的重新啟動將於安裝完成後的1024分鐘內發生
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'RebootWarningTimeoutEnabled' -value '1' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'RebootWarningTimeout' -value '1024' -propertyType "DWord" -force
    #更新好 Patch 檔後, Windows 1440分後提示使用者重新開機
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'RebootRelaunchTimeoutEnabled' -value '1' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'RebootRelaunchTimeout' -value '1440' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'IncludeRecommendedUpdates' -value '22' -propertyType "DWord" -force
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'AUPowerManagement' -value '0' -propertyType "DWord" -force
    #啟用[自動更新]
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'NoAutoUpdate' -value '0' -propertyType "DWord" -force
    #自動下載並排程安裝
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'AUOptions' -value '4' -propertyType "DWord" -force
    #禮拜五
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'ScheduledInstallDay' -value '5' -propertyType "DWord" -force
    #三點
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'ScheduledInstallTime' -value '3' -propertyType "DWord" -force
    #使用wsus server
    New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'UseWUServer' -value '1' -propertyType "DWord" -force

    #New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'RescheduleWaitTimeEnabled' -value '1' -propertyType "DWord" -force
    #New-ItemProperty 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -name 'RescheduleWaitTime' -value '1' -propertyType "DWord" -force

    gpupdate /force
    wuauclt /resetauthorization /detectnow /reportnow

    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-WSUS Completed..."
}