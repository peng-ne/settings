Stop-Process -Name "*SplitCam*" -Force -ErrorAction SilentlyContinue


$exePath = "C:\Program Files\SplitCam\11\SplitCam.exe"
$action = New-ScheduledTaskAction -Execute $exePath
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Days 365)

Register-ScheduledTask -TaskName "SplitCamHidden" -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null
Start-ScheduledTask -TaskName "SplitCamHidden"




Stop-ScheduledTask -TaskName "SplitCamHidden"; Stop-Process -Name "*SplitCam*" -Force -ErrorAction SilentlyContinue
