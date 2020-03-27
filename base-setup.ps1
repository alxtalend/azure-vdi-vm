#https://blog.jourdant.me/post/3-ways-to-download-files-with-powershell

param (
	[Parameter(Mandatory=$false)]
	[string] $OpenVPNProfile # Username
)


function Download-File ($url,$name) {
	$start_time = Get-Date

	Import-Module BitsTransfer
	Start-BitsTransfer -Source $url -Destination $name
	#OR
	#Start-BitsTransfer -Source $url -Destination $name -Asynchronous

	Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}

#https://build.openvpn.net/downloads/releases/
Download-File -url "https://build.openvpn.net/downloads/releases/latest/openvpn-install-latest-stable-win10.exe" -name "openvpn-install.exe"
Download-File -url "https://build.openvpn.net/downloads/releases/tap-windows-9.24.2-I601-Win10.exe" -name "tap-windows-Win10.exe"

#https://justcheckingonall.wordpress.com/2013/03/11/command-line-installation-of-openvpn/
#https://stackoverflow.com/questions/43868325/how-to-silently-install-exe-using-powershell


Start-Process -Wait -FilePath "tap-windows-Win10.exe" -Verb runAs -ArgumentList '/S'
Start-Process -Wait -FilePath "openvpn-install.exe" -Verb runAs -ArgumentList '/S','/SELECT_TAP=0'

if (![string]::IsNullOrEmpty($OpenVPNProfile)) {
    Download-File -url $OpenVPNProfile -name "C:\Program Files\OpenVPN\config\Talend.ovpn"
}

#https://www.google.com/search?q=chrome+silent+setup&rlz=1C1GCEU_frFR853FR853&oq=chrome+silent+setup&aqs=chrome..69i57j0l6.3742j0j8&sourceid=chrome&ie=UTF-8
#https://superuser.com/questions/337210/how-can-i-silently-install-google-chrome
Download-File -url "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5D59F716-B1B6-80E2-AA26-97E223303431%7D%26lang%3Dfr%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe" -name "ChromeStandaloneSetup64.exe"
Start-Process -Wait -FilePath "ChromeStandaloneSetup64.exe" -Verb runAs -ArgumentList '/silent','/install'

#https://slack.com/intl/en-in/help/articles/212475728-Deploy-Slack-via-Microsoft-Installer
Download-File -url "https://slack.com/ssb/download-win64-msi" -name "slack-standalone-4.4.0.0.msi"
Start-Process -Wait -FilePath "msiexec.exe" -Verb runAs -ArgumentList '/i slack-standalone-4.4.0.0.msi','/qn','/norestart'

#https://support.zoom.us/hc/en-us/articles/201362163-Mass-Installation-and-Configuration-for-Windows
Download-File -url "https://www.zoom.us/client/latest/ZoomInstallerFull.msi" -name "ZoomInstallerFull.msi"
Start-Process -Wait -FilePath "msiexec.exe" -Verb runAs -ArgumentList '/i ZoomInstallerFull.msi','/qn','/norestart','/quiet','ZSILENTSTART="true"'

#https://support.zoom.us/hc/en-us/articles/200881399-Module-d-extension-Microsoft-Outlook
Download-File -url "https://zoom.us/client/latest/ZoomOutlookPluginSetup.msi" -name "ZoomOutlookPluginSetup.msi"
Start-Process -Wait -FilePath "msiexec.exe" -Verb runAs -ArgumentList '/i ZoomOutlookPluginSetup.msi','/qn','/norestart','/quiet'

