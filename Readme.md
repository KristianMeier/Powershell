# Open Task Scheduler
Open the Task Scheduler by searching for it in the Start menu or by using the taskschd.msc command in the Run dialog (Windows key + R).

# Create a New Task:

# Step 1
In Task Scheduler, click on "Create Task..." in the right-hand Actions pane.
General Tab:

# Step 2
In the General tab of the Create Task window, give your task a name (e.g., "File Backup Task Simplified") and optionally provide a description.
Triggers Tab:

# Step 3
Click on the Triggers tab and then click "New..." to create a new trigger.
Choose "On a schedule" from the dropdown menu.
Set the "Repeat task every" option to 1 minute.
Ensure it's set to "Indefinitely" for duration.
Click OK to create the trigger.

# Step 4
Actions Tab:
Switch to the Actions tab and click "New..." to create a new action.
In the "Action" dropdown, select "Start a program".
In the "Program/script" field, enter PowerShell.exe.
In the "Add arguments (optional)" field, enter the following:
arduino
Copy code

`-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Path\to\YourScript.ps1"`

Replace "C:\Path\to\YourScript.ps1" with the actual path to your simplified PowerShell script file.

# Step 5
Click OK to create the action.
Conditions and Settings:

Optionally, you can configure conditions and settings in the respective tabs according to your preferences.

# Step 6
Save the Task:

Click OK to save the task.
Once the task is created, it will run the simplified PowerShell script every minute, backing up the specified file. 

# More Info
Make sure to replace "C:\Path\to\YourScript.ps1" with the actual path to your simplified PowerShell script file. Also, ensure that the user account running the task has appropriate permissions to execute the script and access the necessary files and folders.