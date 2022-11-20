# univr-wsl-setup

A script to help CS students of the University of Verona to configure their coding environment, based on the Windows Subsystem for Linux.

## What does this script do

This script is split into three parts:

- the `win_setup.ps1` script, which downloads and installs the latest version of [VcXsrv](https://sourceforge.net/projects/vcxsrv/), creates the firewall rule for it and, if Visual Studio Code is installed and available on PATH, installs the [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) extension;
- the `wsl_setup.sh` script, which installs the packages needed for classes and enables WSL to use the previously installed X server;
- the `setup.ps1` script, which executes the `win_setup.ps1` script, installs WSL (with Ubuntu 18.04 as the distro of choice) and then run `wsl_setup.sh` inside it.

## Installation

This script uses `winget`, which should be provided on recent versions of Windows 10, to install VcXsrv.

Simply open a PowerShell console (with administrative privilege, if needed), and launch the `setup.ps1` from there.

You may need to bypass the ExecutionPolicy before running this script:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
```

## Alternatives

If you are running Windows 11, you might be interested in reading [this guide](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps) instead.
