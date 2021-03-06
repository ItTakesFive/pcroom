#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

param (
    [string]$action = "default"
)


#Import script
$import_function = "ntp", "wsus", "misc", "account", "rename"
foreach ( $function in $import_function){
    . .\"cs-$function".ps1
}

Write-Host -backgroundColor "white" -foregroundcolor "Black" -object "CS-AUTO-Setup-script: $action"

switch ($action){
    wsus {cs-wsus}
    ntp {cs-ntp}
    misc {cs-misc}
    account {cs-account}
    printer {start-process .\cs-printer.bat}
    rename {cs-rename}
    firewall {cs-firewall}
    directory {cs-directory}
    all {
        foreach ($function in $import_function){
            . "cs-$function"
        }
        #Install cs-printer
        start-process .\cs-printer.bat
    }    
    default {
        Write-Host "請選擇以下方法之一或"all"執行全部安裝"
        foreach ($function_name in $import_function){
            Write-Host "$function_name"
        }    
    }
}
