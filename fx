$targets = @("*VidSource2*", "*VidSource3*", "*VidSource4*")
$paths = @(
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{e5323777-f976-4f5b-9b55-b94699c46e44}",
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{65E8773D-8F56-11D0-A3B9-00A0C9223196}"
)
foreach ($p in $paths) {
    if (Test-Path $p) {
        Get-ChildItem -Path $p -Recurse -ErrorAction SilentlyContinue | Where-Object {
            $name = $_.PSChildName
            ($targets | Where-Object { $name -like $_ }).Count -gt 0
        } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}
