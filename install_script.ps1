<#
.SYNOPSIS
    Cybersecurity Environment Setup Script

.DESCRIPTION
    This script installs essential tools and libraries for cybersecurity research and development.

.AUTHOR
    Saiprashanth Pulisetti

.CREATED
    June 2025

.LICENSE
    MIT License

.NOTES
    Created for setting up a complete environment for threat detection, analysis, and red teaming.
#>

# Function to download and install software
function Install-Software {
    param (
        [string]$Url,
        [string]$OutFile,
        [string]$Arguments = '/silent'
    )
    Invoke-WebRequest -Uri $Url -OutFile $OutFile
    Start-Process -FilePath $OutFile -ArgumentList $Arguments -NoNewWindow -Wait
    Remove-Item $OutFile
}

# Install Python
Install-Software -Url "https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe" -OutFile "python-installer.exe" -Arguments "/quiet InstallAllUsers=1 PrependPath=1"

# Install Python Libraries
pip install pandas elasticsearch requests sigma-cli

# Install Git
Install-Software -Url "https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.2/Git-2.33.0-64-bit.exe" -OutFile "git-installer.exe"

# Install Node.js
Install-Software -Url "https://nodejs.org/dist/v14.17.6/node-v14.17.6-x64.msi" -OutFile "node-installer.msi" -Arguments "/i node-installer.msi /quiet"

# Install Visual Studio Code
Install-Software -Url "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile "vscode-installer.exe"

# Install VS Code Extensions
code --install-extension ms-python.python
code --install-extension redhat.vscode-yaml
code --install-extension elastic.elastic-vscode
code --install-extension humao.rest-client

# Install Postman
Install-Software -Url "https://dl.pstmn.io/download/latest/win64" -OutFile "postman-installer.exe"

# Install Sysmon
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Sysmon.zip" -OutFile "Sysmon.zip"
Expand-Archive Sysmon.zip -DestinationPath Sysmon
Start-Process Sysmon/Sysmon64.exe -ArgumentList "-accepteula -i Sysmon/sysmonconfig.xml" -NoNewWindow -Wait
Remove-Item Sysmon.zip
Remove-Item -Recurse Sysmon

# Clone Atomic Red Team repository
git clone https://github.com/redcanaryco/atomic-red-team.git

# Clone MITRE ATT&CK Navigator repository and start it
git clone https://github.com/mitre-attack/attack-navigator.git
Set-Location attack-navigator/nav-app
npm install
npm run start
