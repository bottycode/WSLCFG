$distros = (wsl.exe --list --quiet | Out-String) -replace "`0","" -replace "(`r`n)+","`n"
foreach ($distro in $distros.Trim().Split()) {
	wsl.exe -d $distro -- bash -c "[ -x /etc/rc.local ] && /etc/rc.local start"
}
