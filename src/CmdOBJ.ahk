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
	
	if(STAT.HasKey(msg)){
		mode := msg
	} else {
		mode := "NORMAL"
	}
	set := STAT[mode]
	title := set["title"]
	bg_color := set["bg_color"]
	font_color := set["font_color"]

		xx := A_ScreenWidth/2
		yy := A_ScreenHeight - 58
		Gui, PANEL:Destroy
        Gui, PANEL:+AlwaysOnTop +ToolWindow -Caption
		Gui, PANEL:Color, %bg_color%
        Gui, PANEL:Font, s9 bold, Verdana
        Gui, PANEL:Add, Text, c%font_color%, -- %msg% --
        Gui, PANEL:Show,NoActivate x%xx% y%yy%, %title%
		WinSet, Transparent, 220 , %title%
}

#IfWinExist MODE_WINDOW
F10::
	WinGetPos,TX,TY,TW,TH,ahk_class Shell_TrayWnd,,,
	MsgBox % TH
return
#if