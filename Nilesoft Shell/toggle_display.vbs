Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
tmpFile = WshShell.ExpandEnvironmentStrings("%TEMP%") & "\disp_toggle.flag"

If fso.FileExists(tmpFile) Then
    fso.DeleteFile(tmpFile)
    WshShell.Run "displayswitch.exe /external", 0, False
Else
    fso.CreateTextFile(tmpFile, True).Close
    WshShell.Run "displayswitch.exe /extend", 0, False
End If