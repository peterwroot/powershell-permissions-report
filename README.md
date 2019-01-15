# Get-PermissionsList.ps1

A simple PowerShell script to produce a report of directory permissions.

## Command-Line Switches

|Switch |Function                           |Default            |
|-      |-                                  |-                  |
|-p     | The path to run the report on.    |C:\                |
|-o     | The path to the ouput file.       |C:\permissions.txt |
|-i     | Users/Security groups to exclude. |none               |

### Usage example

`Get-PermissionsList.ps1 -p "D:\Data\" -o "C:\PermissionReport.txt" -i "BUILTIN\Administrators","NT AUTHORITY\SYSTEM","CREATOR OWNER"`

### Report Example

`D:\Data\Program Files`  
` - NT SERVICE\TrustedInstaller`  
` - NT SERVICE\TrustedInstaller`  
` - APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES`  
` - APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES`  
` - APPLICATION PACKAGE AUTHORITY\ALL RESTRICTED APPLICATION PACKAGES`  
` - APPLICATION PACKAGE AUTHORITY\ALL RESTRICTED APPLICATION PACKAGES`  


`D:\Data\Program Files (x86)`  
` - NT SERVICE\TrustedInstaller`  
` - NT SERVICE\TrustedInstaller`  
` - APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES`  
` - APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES`  
` - APPLICATION PACKAGE AUTHORITY\ALL RESTRICTED APPLICATION PACKAGES`  
` - APPLICATION PACKAGE AUTHORITY\ALL RESTRICTED APPLICATION PACKAGES`  