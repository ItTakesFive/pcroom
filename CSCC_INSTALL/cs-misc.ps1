#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-misc{

    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-misc Parameters..."
    
    #不顯示最後使用者
    Set-ItemProperty 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -name 'dontdisplaylastusername' -value '1'  -Type "DWORD"
    
    #關閉離線檔案
    Set-ItemProperty 'HKLM:SYSTEM\CurrentControlSet\services\CscService' -name 'Start' -value '4'  -Type "DWORD"
    
    #TODO 更改語系
    
    #TODO 設定CSCC桌面 CSCC_Wallpapaer/CSCC.png
    
    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-misc Completed..."

}
