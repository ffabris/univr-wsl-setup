# You may need to bypass the ExecutionPolicy before running this script
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# You can find the releases of VcXsrv Windows X Server in the link below
# https://sourceforge.net/projects/vcxsrv/files/vcxsrv/

# Install the X server of choice
winget install --exact --id marha.VcXsrv

# Set firewall rule for the X server
# See: https://stackoverflow.com/a/61110604
Write-Host "Generating firewall rule... " -NoNewline
$rule = @{ 'DisplayName'   = 'X server for WSL';
           'Direction'     = 'Inbound';
           'Protocol'      = 'TCP';
           'LocalPort'     = '6000';
           'RemoteAddress' = '172.16.0.0/12' }
[void](New-NetFirewallRule @rule)
Write-Host "done."

# If Visual Studio Code is installed, install the "Remote - WSL" extension
if (Get-Command code -ErrorAction SilentlyContinue) {
    $vsc_ext = "ms-vscode-remote.remote-wsl"
    if (!(code --list-extensions | Select-String -Quiet -Pattern $vsc_ext)) {
        Write-Host "Installing $vsc_ext... " -NoNewline
        code --install-extension $vsc_ext --force
        Write-Host "done."
    }
}

# Windows is ready!
Write-Host "`nTweaking of Windows completed.`n"
