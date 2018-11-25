Set ws = WScript.CreateObject("WScript.Shell")
cmd2 = "C:\Windows\System32\bash.exe -c ""bash /init.sh"""
cmd1 = "sc start LxssManager"
cmd3 = "sc stop LxssManager"
' 运行命令不显示cmd窗口
ws.Run cmd3, 0, false
ws.Run cmd1, 0, false
ws.Run cmd2, 0, false
Set ws = Nothing
