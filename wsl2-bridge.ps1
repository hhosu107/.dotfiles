$remoteport = bash.exe -c "ip addr | grep -E 'inet.*eth0'"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if ($found)
{
    $remoteport = $matches[0];
}
else
{
    echo "The Script Exited, the ip address of WSL 2 cannot be found";
    exit;
}

#[Ports]
# All the ports you want to forward separated by coma
$ports = @(22, 80, 443, 3000, 8000, 8042, 8080, 8081, 8888);


#[Static IP]
# You can change the addr to your ip config to listen to a specific address
$addr = '0.0.0.0';
$ports_a = $ports -join ",";

# Remove Firewall Exception Rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock'" -ErrorAction SilentlyContinue;

# Add Exception Rules for inbound and outbound Rules
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";

foreach ($port in $ports)
{
    iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
    iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
}
