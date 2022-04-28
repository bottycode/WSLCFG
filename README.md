# WSLCFG

This repository contains files that are used to configure WSL (Windows Subsystem for Linux).

## ps1_runner.js

This file is used to execute a powershell script quietly (i.e. without a window show up).
It can be used with `taskschd.msc`.

Example usage:

```
wscript.exe .\ps1_runner.js .\foo.ps1 --bar baz
```

## startup.ps1

Execute `/etc/rc.local` for every WSL distribution if the file is executable.

## hosts.ps1

Add/modify the corresponding entry in windows `hosts` file, so that we can access WSL by domain names like `debian.wsl` and `ubuntu-20.04.wsl`.

## firewall.ps1

The network interface for WSL2 A.K.A. vEthernet (WSL) is public by default.
This script excludes the WSL interface from being protected by the public firewall profile.

See [WSL #4139](https://github.com/microsoft/WSL/issues/4139).
