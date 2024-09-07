# Define paths
$destinationPath = "C:\aeacus"
$zipFilePath = "$destinationPath\aeacus-win32.zip"
$extractedFolder = "$destinationPath\aeacus-win32"
$downloadUrl = "https://github.com/elysium-suite/aeacus/releases/download/v2.1.1/aeacus-win32.zip"

# Ensure the destination directory exists
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath
}

# Download the file
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath

# Extract the zip file
Expand-Archive -Path $zipFilePath -DestinationPath $destinationPath -Force

# Move contents from the extracted folder to the destination path
if (Test-Path $extractedFolder) {
    Get-ChildItem -Path $extractedFolder | Move-Item -Destination $destinationPath -Force
    # Remove the empty folder
    Remove-Item -Path $extractedFolder -Recurse
}

# Clean up the zip file
Remove-Item -Path $zipFilePath

# Check if scoring.conf doesn't exist
if (-not (Test-Path "C:\aeacus\scoring.conf")) {
    Copy-Item -Path "C:\vagrant\windows-scoring.conf" -Destination "C:\aeacus\scoring.conf" -Force
} 


Copy -Recurse -Force "C:\aeacus\windows\GroupPolicy\*" "C:\windows\system32\GroupPolicy"

Copy -Force "C:\aeacus\windows\windows-scoring.conf" "C:\aeacus\scoring.conf"

echo "Nothing_To_See_Here" > C:/aeacus/TeamID.txt

Copy -Force "C:\aeacus\windows\ReadMe.conf" "C:\aeacus\ReadMe.conf"

gpupdate.exe /Force

Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name "NoAutoUpdate"

# disable automatic updates
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1

# disable windows update service
Set-Service -StartupType Disabled -Name 'wuauserv'

# stop windows update servcie
Stop-Service -Name 'wuauserv'


# disable defender
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name "DisableAntiSpyware" -Value 1

# disable RDP
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name "fDenyTSConnections" -Value 1


rm -Recurse -Force C:/aeacus/windows
rm -Force C:/aeacus/windows.zip


C:/aeacus/aeacus.exe --yes release

rm -Force C:/aeacus/aeacus.exe

shutdown.exe /f /r


