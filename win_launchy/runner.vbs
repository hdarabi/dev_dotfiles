batname = "cmd /c "
for each arg in WScript.Arguments
    batname = batname + " " + arg
next
Set oShell = CreateObject("Wscript.Shell")
oShell.Run batname, 0, false
