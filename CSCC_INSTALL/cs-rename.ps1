#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-rename {
    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-rename Parameters..."

    [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
    $name = [Microsoft.VisualBasic.Interaction]::InputBox("Enter Desired Computer Name ")
    $computerName = Get-WmiObject Win32_ComputerSystem
    $computername.Rename($name)
    Get-WmiObject Win32_ComputerSystem
    
    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-rename Completed..."

}