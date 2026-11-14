Unregister-ScheduledTask -TaskName "SplitCamHidden" -Confirm:$false -ErrorAction SilentlyContinue; Stop-Process -Name "*SplitCam*" -Force -ErrorAction SilentlyContinue
