$classes = @(
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{e5323777-f976-4f5b-9b55-b94699c46e44}",
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{65e8773d-8f56-11d0-a3b9-00a0c9223196}",
    "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{6994ad05-93ef-11d0-a3cc-00a0c9223196}"
)

foreach ($c in $classes) {
    if (Test-Path $c) {
        Get-ChildItem -Path $c -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
            if ($_.PSChildName -eq "#VidSource1") {
                $dp = Join-Path $_.PSPath "Device Parameters"
                if (Test-Path $dp) {
                    Set-ItemProperty -Path $dp -Name "FriendlyName" -Value "DV20 USB CAMERA" -Force
                }
                $ctrl = Join-Path $_.PSPath "Control"
                if (Test-Path $ctrl) {
                    Set-ItemProperty -Path $ctrl -Name "Linked" -Value 1 -Type DWord -Force
                }
            }
            elseif ($_.PSChildName -match "^#VidSource[2-4]$") {
                $acl = Get-Acl $_.PSPath
                $rule = New-Object System.Security.AccessControl.RegistryAccessRule("Everyone", "ReadKey", "ContainerInherit,ObjectInherit", "None", "Deny")
                $acl.SetAccessRule($rule)
                Set-Acl -Path $_.PSPath -AclObject $acl
            }
        }
    }
}
