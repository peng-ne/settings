$warpExe = "warp-cli"
if (-not (Get-Command "warp-cli" -ErrorAction SilentlyContinue)) {
    $warpExe = "C:\Program Files\Cloudflare\Cloudflare WARP\warp-cli.exe"
}

# Lấy trạng thái hiện tại (chuyển thành chuỗi chữ thường)
$statusOut = (& $warpExe status 2>&1) | Out-String
$status = $statusOut.ToLower()

# Kiểm tra chính xác trạng thái Connected
if ($status -like "*connected*" -and $status -notlike "*disconnected*") {
    & $warpExe disconnect | Out-Null
    $msg = "Cloudflare WARP: Da TAT"
} else {
    & $warpExe connect | Out-Null
    $msg = "Cloudflare WARP: Da BAT"
}

# Hiển thị thông báo Popup trên màn hình
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup($msg, 2, "Trang thai WARP", 64)