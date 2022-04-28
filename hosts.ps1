$wsl_hosts = @{}
$hostfile = "$env:windir\System32\drivers\etc\hosts"

$distros = (wsl.exe --list --quiet | Out-String) -replace "`0","" -replace "(`r`n)+","`n"
foreach ($distro in $distros.Trim().Split()) {
	$hostname = "{0}.wsl" -f $distro.ToLower()
	$ifname = (wsl.exe -d $distro ip --json route show default | ConvertFrom-Json).dev
	$ifinfo = (wsl.exe -d $distro ip --json address show $ifname | ConvertFrom-Json).addr_info
	$wsl_hosts.add($hostname, ($ifinfo | Where-Object family -EQ inet).local)
}

$hosts = Get-Content -Path $hostfile
foreach ($hostname in $wsl_hosts.keys) {
	$ipaddr = $wsl_hosts[$hostname]
	$hosts = $hosts -notmatch ('^\s*\d+\.\d+\.\d+\.\d+\s+{0}\b' -f $hostname)
	$hosts += "{0}`t{1}`t# Add at {2}" -f $ipaddr, $hostname, (Get-Date -UFormat "%Y-%m-%d %H:%M:%S")
}

while ($true) {
	try {
		Set-Content -Path $hostfile -Value $hosts -ErrorAction Stop
		break
	} catch {
		Start-Sleep -Seconds 1
	}
}
