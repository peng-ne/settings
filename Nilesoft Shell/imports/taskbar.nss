menu(type="taskbar" vis=key.shift() or key.lbutton() pos=0 title=app.name image=\uE249)
{
	item(title="config" image=\uE10A cmd='"@app.cfg"')
	item(title="manager" image=\uE0F3 admin cmd='"@app.exe"')
	item(title="directory" image=\uE0E8 cmd='"@app.dir"')
}


menu(type='taskbar' image=icon.settings expanded=true)
{
	item(
		title='Switcher'
		image=icon.display_settings
		cmd='wscript.exe'
		args='"@app.dir\toggle_display.vbs"'
	)
item(
	title='1.1.1.1'
	image=icon.cloudflare
	cmd = 'schtasks.exe'
	args = '/run /tn "ToggleWarp"'
)

	item(title=title.settings image=icon.settings(auto, image.color1) cmd='ms-settings:')
menu(type='taskbar' title='Boots' image=icon.window)
{
    item(title='WPC' admin=true command='cmd.exe' args='/c bcdedit /bootsequence {7c312cdb-ae6a-11f1-916b-d35925181f47} && shutdown /r /t 0')
    item(title='PPC' admin=true command='cmd.exe' args='/c bcdedit /bootsequence {eadbf50d-aee0-11f1-88a0-f7569d17cc65} && shutdown /r /t 0')
}
	item(title=title.task_manager sep=both image=icon.task_manager cmd='taskmgr.exe')
	item(title=title.taskbar_Settings sep=both image=inherit cmd='ms-settings:taskbar')
	item(vis=key.shift() title=title.exit_explorer cmd=command.restart_explorer)
}