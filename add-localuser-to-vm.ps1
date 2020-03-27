#require set-executionpolicy remotesigned

param (
	[Parameter(Mandatory=$true)]
	[string] $User, # Username
	
	[Parameter(Mandatory=$false)]
	[string] $FullName=$User, # User FullName
	
	[Parameter(Mandatory=$false)]
	[string] $Description=-join ($FullName," local account"), # User Description
	
	[Parameter(Mandatory=$false)]
	[ValidateSet('Power Users','Administrators')]
	[string] $Group="Power Users", # User Group
	
	[Parameter(Mandatory=$true)]
	[ValidateNotNullOrEmpty()]
	[string]$Password=$(Throw "Password required.")
#	[Security.SecureString]$Password=$(Throw "Password required.")

)

#$User					= "testUser"
#$FullName				= "testUser"
#$Description			= "testUser"
#$Password 				= Read-Host -AsSecureString

#$Group					= "Power Users"

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-7
$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force

#Write-Host $securePassword

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/new-localuser?view=powershell-5.1
New-LocalUser "$user" -Password $securePassword -FullName $FullName -Description $Description

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/add-localgroupmember?view=powershell-5.1
#Add-LocalGroupMember -Group "Power Users" -Member $User
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $User
Add-LocalGroupMember -Group "Administrators" -Member $User