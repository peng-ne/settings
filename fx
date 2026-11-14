$paths = @(
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{e5323777-f976-4f5b-9b55-b94699c46e44}",
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{65E8773D-8F56-11D0-A3B9-00A0C9223196}"
)
foreach ($p in $paths) {
    Get-ChildItem -Path $p -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        $fn = (Get-ItemProperty -Path $_.PSPath -Name "FriendlyName" -ErrorAction SilentlyContinue).FriendlyName
        if ($fn -match "NDI Webcam Video [2-4]") {
            $parent = $_.PSParentPath
            Write-Host "Found: $fn at $parent"
            New-ItemProperty -Path $parent -Name "DeviceState" -Value 0 -PropertyType DWord -Force | Out-Null
        }
    }
}
