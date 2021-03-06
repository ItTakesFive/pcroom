#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

# Create path & locations
$scriptPathString = [string](split-path -parent $MyInvocation.MyCommand.Definition)
$rootPathString = $scriptPathString + "\..\"
$paperPathString = convert-path ($rootPathString + "\CSCC_Wallpaper\CSCC.jpg")
$NTUSER_Path = $scriptPathString + "\Default_User\NTUSER.DAT"




Function cs-misc{

    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-misc Parameters..."
    
    # 不顯示最後使用者
    Set-ItemProperty 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -name 'dontdisplaylastusername' -value '1'  -Type "DWORD"
    
    # 關閉離線檔案
    Set-ItemProperty 'HKLM:SYSTEM\CurrentControlSet\services\CscService' -name 'Start' -value '4'  -Type "DWORD"
    
    # Change Time Zone
    tzutil /s "Taipei Standard Time"

    # Remove old NTUSERDAT
    del -force -path "C:\Users\Default\NTUSER.DAT"
    # 複製新使用者的登錄資訊
    cp -force $NTUSER_Path "C:\Users\Default"
    # Set Locale Info (for software)
    Set-Location Registry::\HKEY_USERS
    $R_path = ".\.DEFAULT"
    Set-ItemProperty $R_path "Locale" "00000404"
    Set-ItemProperty $R_path "LocaleName" "zh-TW"
    Set-ItemProperty $R_path "s1159" "上午"
    Set-ItemProperty $R_path "s2359" "下午"
    Set-ItemProperty $R_path "sCountry" "台灣"
    Set-ItemProperty $R_path "sCurrency" "NT$"
    Set-ItemProperty $R_path  "sDate" "/"
    Set-ItemProperty $R_path "sDecimal" "."
    Set-ItemProperty $R_path "sGrouping" "3;0"
    Set-ItemProperty $R_path "sLanguage" "CHT"
    Set-ItemProperty $R_path "sList" ","
    Set-ItemProperty $R_path "sLongDate" "yyyy'年'M'月'd'日'"
    Set-ItemProperty $R_path "sMonDecimalSep" "."
    Set-ItemProperty $R_path "sMonGrouping" "3;0"
    Set-ItemProperty $R_path "sMonThousandSep" ","
    Set-ItemProperty $R_path "sNativeDigits" "0123456789"
    Set-ItemProperty $R_path "sNegativeSign" "-"
    Set-ItemProperty $R_path "sPositiveSign" ""
    Set-ItemProperty $R_path "sShortDate" "yyyy/M/d"
    Set-ItemProperty $R_path "sThousand" ","
    Set-ItemProperty $R_path "sTime" ":"
    Set-ItemProperty $R_path "sTimeFormat" "tt hh:mm:ss"
    Set-ItemProperty $R_path "sShortTime" "tt hh:mm"
    Set-ItemProperty $R_path "sYearMonth" "yyyy'年'M'月'"
    Set-ItemProperty $R_path "iCalendarType" "1"
    Set-ItemProperty $R_path "iCountry" "886"
    Set-ItemProperty $R_path "iCurrDigits" "2"
    Set-ItemProperty $R_path "iCurrency" "0"
    Set-ItemProperty $R_path "iDate" "2"
    Set-ItemProperty $R_path "iDigits" "2"
    Set-ItemProperty $R_path "NumShape" "1"
    Set-ItemProperty $R_path "iFirstDayOfWeek" "6"
    Set-ItemProperty $R_path "iFirstWeekOfYear" "0"
    Set-ItemProperty $R_path "iLZero" "1"
    Set-ItemProperty $R_path "iMeasure" "0"
    Set-ItemProperty $R_path "iNegCurr" "1"
    Set-ItemProperty $R_path "iNegNumber" "1"
    Set-ItemProperty $R_path "iPaperSize" "9"
    Set-ItemProperty $R_path "iTime" "0"
    Set-ItemProperty $R_path "iTimePrefix" "1"
    Set-ItemProperty $R_path "iTLZero" "1"
    
    # 設定CSCC桌面 CSCC_Wallpapaer/CSCC.jpg
    # This setting only affect newly created user
    # Change to Wallpaper folder
    cd C:\Windows\Web\Wallpaper
    # Change owner to admin
    TAKEOWN /F Windows /R /A
    # Grant all permissions to admin
    ICACLS Windows /grant administrators:F /T
    # Replace pictures
    cp $paperPathString .\Windows\img0.jpg
    
    # End of Task
    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-misc Completed..."

}