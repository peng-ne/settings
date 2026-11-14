Get-PnpDevice | Where-Object {
    ($_.FriendlyName -like "*NDI Webcam Video*" -or $_.InstanceId -like "*VidSource2*" -or $_.InstanceId -like "*VidSource3*" -or $_.InstanceId -like "*VidSource4*") -and
    ($_.FriendlyName -ne "DV20 USB CAMERA")
} | Disable-PnpDevice -Confirm:$false
