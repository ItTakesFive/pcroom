#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-firewall {
    #Allow java
    New-NetFirewallRule -DisplayName “Allow java” -Direction Outbound -Program C:\Program Files\Java\jre7\bin\java.exe -RemoteAddress Any -Action Allow

}