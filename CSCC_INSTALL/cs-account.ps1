#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-account {
    
    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-account Parameters..."

    #Local temp account 
    NET USER pcuser cscs /ADD
    
    #TODO Add "exam" account
    
    #TODO User permission setting
    
    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-account Completed"

}
