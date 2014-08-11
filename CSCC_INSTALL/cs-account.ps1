#Maintainer: pichunag <pichuang@cs.nctu.edu.tw>

Function cs-account {
    
    Write-Host -backgroundColor white -foregroundcolor blue -object "Setting CS-account Parameters..."

    #Local temp account 
    NET USER pcuser cscs /ADD
    
    # Add "exam" account
    NET USER exam "cccs" /ADD
    
    # User permission setting
    # Remove user permission settings
    remove-user-permission "D:\" "Authenticated Users"
    remove-user-permission "D:\" "Users"
    remove-user-permission "C:\" "Authenticated Users"
    remove-user-permission "C:\" "Users"
    
    # Force set Everyone permission to C:\
    # /e Edit ACL(permission)
    # /c Ignore errors or warning
    # /g <user>:{r|c|f} permisson setting
    cacls C:\ /e /c /g Everyone:r
    
    # Will raise error, insteaded by cacls
    #set-permission "C:\" "Everyone" @{"Read"="Allow"; "Write"="Deny"}
    set-permission "D:\" "Everyone" @{"Read"="Allow"; "Write"="Deny"}

    set-permission "D:\Temp" "Everyone" @{"Read"="Allow"; "Write"="Allow"}

    set-permission "D:\Temp" "exam" @{"FullControl"="Deny"}
    #set-permission "D:\exam" "exam" @{"Read"="Allow"; "Write"="Allow"}
    
    # exam all permissions on D:\exam
    $permission = @{
        "AppendData" = "Allow";
        "CreateDirectories" = "Allow";
        "CreateFiles" = "Allow";
        "Delete" = "Allow";
        "DeleteSubdirectoriesAndFiles" = "Allow";
        "ExecuteFile" = "Allow";
        "ListDirectory" = "Allow";
        "Modify" = "Allow";
        "Read" = "Allow";
        "ReadAndExecute" = "Allow";
        "ReadAttributes" = "Allow";
        "ReadData" = "Allow";
        "ReadExtendedAttributes" = "Allow";
        "ReadPermissions" = "Allow";
        "Synchronize" = "Allow";
        "Traverse" = "Allow";
        "Write" = "Allow";
        "WriteAttributes" = "Allow";
        "WriteData" = "Allow";
        "WriteExtendedAttributes" = "Allow";
    }
    set-permission "D:\exam" "exam" $permission

    Write-Host -backgroundColor white -foregroundcolor blue -object "CS-account Completed"

}

<#
Set user permissions of folder
@$folder path
@$user user name
@$datas permission datas (key, value pair)
#>
Function set-permission($folder, $user, $datas) {
    
    $acl = Get-Acl $folder
    
    foreach($data in $datas.GetEnumerator()) {
        $permission = $user, $data.Name, "ContainerInherit, ObjectInherit", "None", $data.Value
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
        $acl.AddAccessRule($rule)
    }
    
    $acl | Set-Acl $folder
}

<#
Remove user permission on folder
@$folder path
@$user user name
#>
Function remove-user-permission($folder, $user) {

    $permission = "Modify"
    $Account = New-Object System.Security.Principal.NTAccount($user)
    $FileSystemRights = [System.Security.AccessControl.FileSystemRights]$permission
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]"None"
    $AccessControlType =[System.Security.AccessControl.AccessControlType]::Allow
    $FileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, $FileSystemRights, $InheritanceFlag, $PropagationFlag, $AccessControlType)
    $FileSecurity = (Get-Item $folder).GetAccessControl('Access')
    $FileSecurity.RemoveAccessRuleAll($FileSystemAccessRule)
    Set-ACL $folder -AclObject $FileSecurity
}