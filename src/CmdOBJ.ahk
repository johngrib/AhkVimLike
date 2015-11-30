/*
	command object
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 29
*/
class CmdOBJ {
		__New(cmd, num) {
			this.cmd := cmd
			this.num := num
		}
		set_cmd(cmd){
			this.cmd := cmd
		}
		set_num(num){
			this.num := num
		}
		get_num(){
			return this.num
		}
		get_cmd(){
			return this.cmd
		}
		get_num_cmd(){
			return this.num . this.cmd
		}
		append_num(num){
			this.num := this.num . num
		}
		append_cmd(cmd){
			this.cmd := this.cmd . cmd
		}
		clear(str){
			if(str = "auto"){
				this.cmd := ""
				this.num := ""
				this.changeMode("auto")
			} else if(str = "num") {
				this.num := ""
			} else if(str = "cmd") {
				this.cmd := ""
			}
		}
		/* 
			capslock mode changer
		*/
		changeMode(opt){
			KeyWait, CapsLock
			GetKeyState, lockState, CapsLock, T)
			If(lockState = "D" && opt == "auto")	{
				option = on
				show_mode("NORMAL")
			} else If(lockState = "D" && opt == "caps")	{
				option = off
				show_mode("CAPSLOCK")
			} else {
				option = off
				show_mode("INSERT")
			}

			; enable / disable command hot keys
			command_keymap := func_get_key_maps()
			cnt := command_keymap.Length()
			Loop %cnt%
			{
				target_key := command_keymap[A_Index]
				Hotkey, %target_key%, %option%
			}
			return
		}
}

show_mode(msg){
	
	if(STAT.HasKey(msg))
		mode := msg
	else
		mode := "NORMAL"

	set := STAT[mode]
	bg_color := CFG.get_value(mode, "bg_color")
	font_color := CFG.get_value(mode, "font_color")

	create_gui("PANEL", set["title"], msg, STAT_LOC["x"], STAT_LOC["y"], bg_color, font_color)
}

create_gui(id, title, msg, x, y, bg_color, font_color){
		Gui, %id%:Destroy
        Gui, %id%:+AlwaysOnTop +ToolWindow -Caption
		Gui, %id%:Color, %bg_color%
        Gui, %id%:Font, s9 bold, Verdana
        Gui, %id%:Add, Text, c%font_color%, -- %msg% --
        Gui, %id%:Show,NoActivate x%x% y%y%, %title%
		WinSet, Transparent, 220 , %title%
}