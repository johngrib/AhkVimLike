/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

/*	
	Capslock is mode changer in this program
	command  - Mode like VIM. (Arrow keys and Mouse controls)
	insert   - Normal key input mode.
	capslock - Normal Capslock mode.
*/
CapsLock::
+Capslock::
	input_number := ""
	
	GetKeyState, lockState, CapsLock, T)
	if(lockState == "D"){
		SetCapsLockState, Off
	} else {
		SetCapsLockState, On
	}

	if(1 == GetKeyState("shift", "P")){
		changeMode("caps")
	} else {
		changeMode("auto")	
	}
	Send, {LShift up}
return

/* 
    capslock mode changer
*/
changeMode(opt) {
	KeyWait, CapsLock
	GetKeyState, lockState, CapsLock, T)
	If(lockState = "D" && opt == "auto")	{
		msg := "---- COMMAND MODE ----"
		option = on
		showToolTip(msg, 1000, 1000)
	} else If(lockState = "D" && opt == "caps")	{
		msg := "CAPSLOCK"
		option = off
		showToolTip(msg, 1000, 1000)
	} else {
		msg := "Insert"
		option = off
		showToolTip(msg, 1000, 1000)
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

/* 
	tooltip controller
*/
showToolTip(msg, sec, afterSec) {
	CoordMode, ToolTip, screen
	ToolTip, %msg%, A_ScreenWidth/2, A_ScreenHeight
	if(sec > 0)
		SetTimer, RemoveToolTip, off
	if(afterSec > 0){
		SetTimer, showModeToolTip, off
	}
	return
}
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
showModeToolTip:
	KeyWait, CapsLock
	GetKeyState, lockState, CapsLock, T
	If(lockState = "D")	{
		showToolTip("-- COMMAND MODE --", -1, -1)
	} else {
		showToolTip("-- INSERT --", -1, -1)
	}
return