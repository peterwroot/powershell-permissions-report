param(
    #The directory we want to run the report on. Default is C:\
    [alias("p","path")]
    [string]$BaseDirectory = "C:\",
    #The file we want to save the report to. Default is C:\permissions.txt
    [alias("o","output")]
    [string]$file = "C:\Permissions.txt",
    #A list of security groups/users to exclude from the report. 
    [alias("i","ignore")]
    [array]$IgnoredSecurityGroups = @()
)

#Clears the terminal window. 
Clear-Host

#Removes the report file if it already exists. 
if(test-path $file){
    remove-item $file
}

#Uses REGEX to check if the provided $BaseDirectory ends in a backslash. Adds the backslash if it doesn't 
if($BaseDirectory -notmatch '.+?\\$'){
    $BaseDirectory += "\"
}

#Retrieves a list of sub-directories in the $BaseDirectory. Doesn't include files. 
$SubDirectoryArray = Get-ChildItem -Path $BaseDirectory -Attributes Directory

#For each sub-directory in the base directory...
foreach($SubDirectory in $SubDirectoryArray){

    #Concatenate the base directory and the subdirectory to produce a full path. 
    $FullPath = "$BaseDirectory$SubDirectory"
    #Writes the path to the report
    Add-Content -Path $file -Value $FullPath

    #Creates a temporary array to store the subdirectory's list of permissions. 
    $Temp_PermissionsList = @()

    #Gets each item in the Access Control List for the subdirectory, and then adds the "identity reference" to the Temporary permissions list variable. 
    Get-Acl -path $FullPath | Select-Object -ExpandProperty Access | ForEach-Object {
        $Temp_PermissionsList += $_.IdentityReference
    }

    #Writes the items in the temporary permissions list variable to the report. 
    foreach ($perm in $Temp_PermissionsList){
        #Creates a string from the $perm object so we can compare it to the ignored users/groups array.
        [string]$PermToCompare = $perm
        #Only writes the user/group to the report if it's not one that we're choosing to ignore. 
        if(-not $IgnoredSecurityGroups.contains($PermToCompare)){
            Add-Content -Path $file -Value " - $perm"
        }
    }

    #Writes a blank line to the report for ease of reading. 
    Add-Content -Path $file -Value "`n"

}