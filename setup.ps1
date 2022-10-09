# You may need to bypass the ExecutionPolicy before running this script
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

$win_script = "win_setup.ps1"
$wsl_script = "wsl_setup.sh"
$wsl_cmd = "ubuntu-18.04"

# Start the powershell script
Write-Host "Executing $win_script..."
& $PSScriptRoot\$win_script

# Start the bash script in "$wsl_cmd", if available
if (Get-Command $wsl_cmd -ErrorAction SilentlyContinue) {
    Write-Host "Executing $wsl_script..."
    Push-Location -Path "$PSScriptRoot"
    & $wsl_cmd run bash $wsl_script
    Pop-Location

    # Job done!
    Write-Host "`nYou are ready to clone and run MentOS."
    Write-Host "https://github.com/mentos-team/MentOS"
    Write-Host "Enjoy the rest of your semester!"
} else {
    # Install the distribution referenced by "$wsl_cmd", if needed
    Write-Host "$wsl_cmd not found."
    Write-Host "Installing $wsl_cmd..."
    wsl --install --distribution $wsl_cmd
    Write-Host "After reboot, run '$wsl_script' in $wsl_cmd."
}
