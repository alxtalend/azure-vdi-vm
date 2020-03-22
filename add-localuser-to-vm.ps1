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
	
#	[Parameter(Mandatory=$true)]
#	[string] $VirtualNetworkName, # VNet
	
#	[Parameter(Mandatory=$true)]
#	[string] $SubnetName, # Subnet
	
#	[Parameter(Mandatory=$true)]
#	[string] $SecurityGroupName, # NSG
	
#	[Parameter(Mandatory=$false)]
#	[string] $VMSize, # VM Size
	
#	[Parameter(Mandatory=$false)]
#	[switch] $AssignPublicIP, # Assign PIP
	
#	[Parameter(Mandatory=$false)]
#	[pscredential]$VMCredential, # VM login credential
	
#	[Parameter(Mandatory=$false)]
#	[Int[]] $AllowedPorts # NSG rules
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

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force

#Write-Host $securePassword

New-LocalUser "$user" -Password $securePassword -FullName $FullName -Description $Description

Add-LocalGroupMember -Group "Power Users" -Member $User
Add-LocalGroupMember -Group "Remote Desktop Users" -Member $User