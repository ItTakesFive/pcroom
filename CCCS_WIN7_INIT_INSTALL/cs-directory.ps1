#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-directory {
    
    #設定user profile至D:\Users
    Set-ItemProperty 'HLKM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' -name 'ProfilesDirectory' -value 'D:\Users' -Type "EXPANDSZ"
    
    #

}