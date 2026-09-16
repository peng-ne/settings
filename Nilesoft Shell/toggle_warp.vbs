Set Shell = CreateObject("WScript.Shell")

' Kiểm tra trạng thái kết nối từ warp-cli
Set exec = Shell.Exec("warp-cli status")
statusOutput = exec.StdOut.ReadAll()

' Nếu output chứa "Connected", thực hiện ngắt kết nối; ngược lại thì kết nối
If InStr(statusOutput, "Connected") > 0 Then
    Shell.Run "warp-cli disconnect", 0, True
Else
    Shell.Run "warp-cli connect", 0, True
End If