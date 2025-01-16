Write-Host "Deploying scripts"

if (!$env:AUTOMATION) {
    Write-Error "La variable d'environnement AUTOMATION n'existe pas"
    exit
}

Remove-Item -Force -Recurse (Join-Path $env:AUTOMATION "backup") -ErrorAction SilentlyContinue
Copy-Item -Path (Join-Path 'src' '*.ps1') -Destination $env:AUTOMATION
Copy-Item -Path (Join-Path 'src' 'backup') -Destination $env:AUTOMATION -Recurse


#--------------------------------------
#region Task Scheduler

# Daily Backups
$params = @{
	TaskName = "Daily backups"
	TaskPath = "\francois\backups"
	Description = "Execute les scripts de backups dans D:\automation\backup"
	User = "francois"
	Trigger = New-ScheduledTaskTrigger -Daily -At 8pm
	Action = @(
        New-ScheduledTaskAction -Execute "pwsh" -Argument "-NoProfile D:\automation\daily.bkp.ps1"
	)
}
Register-ScheduledTask @params -Force

# Weekly Backups
$params = @{
	TaskName = "Weekly backups"
	TaskPath = "\francois\backups"
	Description = "Execute les scripts de backups dans D:\automation\backup"
	User = "francois"
	Trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Sunday -At 9pm
	Action = @(
        New-ScheduledTaskAction -Execute "pwsh" -Argument "-NoProfile D:\automation\weekly.bkp.ps1"
	)
}
Register-ScheduledTask @params -Force

# Monthly Backups
$params = @{
	TaskName = "Monthly backups"
	TaskPath = "\francois\backups"
	Description = "Execute les scripts de backups dans D:\automation\backup"
	User = "francois"
	Trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Sunday -At 10pm
	Action = @(
        New-ScheduledTaskAction -Execute "pwsh" -Argument "-NoProfile D:\automation\monthly.bkp.ps1"
	)
}
Register-ScheduledTask @params -Force

# Raktar - Credentials
# Cree la tache qui prepare les "credentials" pour les partages Raktar
$params = @{
	TaskName = "Logon Script"
	TaskPath = "\francois"
	Description = "Demarre le script au logon"
	User = "francois"
	Trigger = @(
		New-ScheduledTaskTrigger -AtLogOn -User "francois"
	)
	Action = @(
		New-ScheduledTaskAction -Execute "pwsh" -Argument "D:\automation\logon.ps1"
	)
}
Register-ScheduledTask @params -Force
#endregion Task Scheduler
