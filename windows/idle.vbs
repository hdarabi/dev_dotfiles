Dim objResult

Set objShell = WScript.CreateObject("WScript.Shell")    
i = 0

Do While i = 0
  objResult = objShell.sendkeys("{NUMLOCK}{NUMLOCK}")
  Wscript.Sleep (6000)
Loop