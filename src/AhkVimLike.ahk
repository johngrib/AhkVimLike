/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#NoEnv
#SingleInstance
#NoTrayIcon
#Persistent
#include Config.ahk
#include KeyMaps.ahk		; key define
#Include Utilities.ahk		; utility functions
#Include VimLike.ahk		; Vim like key setting
#Include Functions.ahk	; Mouse control functions
#include Commands.ahk	; Command functions
#include CmdOBJ.ahk

SendMode Input
SetDefaultMouseSpeed, 0 
SetKeyDelay, -1
SetMouseDelay, -1
SetWorkingDir %A_ScriptDir%

CapsLock & F5:: Reload
CapsLock & F4:: ExitApp

global MARK
global CMD
global STAT
global STAT_LOC
global STAT_HEIGHT
global CFG

main(){
	Static init := main()
	
	CFG := new Config(".\ahkvimlike.ini")
	
	MARK := {}
	STAT := {}
	STAT["NORMAL"] := {"title": "avl_normal", "bg_color": "000000", "font_color": "FF0000" }
	STAT["INSERT"] := {"title": "avl_insert", "bg_color": "3F51B5", "font_color": "FFFFFF" }
	STAT["CAPSLOCK"] := {"title": "avl_capslock", "bg_color": "FF4081", "font_color": "FFFFFF" }

	STAT_HEIGHT := get_stat_height()

	STAT_LOC := func_get_stat_location()

	CMD := new CmdOBJ("", "")
	CMD.changeMode("auto")
}

get_stat_height(){
	create_gui("PANEL", "size_test", "NORMAL", 0, 0, "000000", "FFFFFF")
	WinGetPos,xx,yy,ww, hh, size_test
	return hh
}