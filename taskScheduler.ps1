$Action = New-ScheduledTaskAction 
-Execute 'PowerShell.exe'
-Argument 'C:\Scripts\MyScript.ps1'

$Trigger = New-ScheduledTaskTrigger
-At 7am -Daily

Register-ScheduledTask
-Action $Action 
-Trigger $Trigger
-TaskName "MyTask"
-Description "My daily PowerShell script"