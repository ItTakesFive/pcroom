#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-firewall {
    #Allow java
    New-NetFirewallRule -DisplayName “Allow java” -Direction Outbound -Program C:\Program Files\Java\jre7\bin\java.exe -RemoteAddress Any -Action Allow
    
    #TODO Allow sshd
    
    #TODO Allow File and Print Sharing 192.168.0.0/16 

}
