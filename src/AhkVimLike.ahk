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
;SetWorkingDir %A_ScriptDir%

CapsLock & F5:: Reload
CapsLock & F4:: ExitApp

global MARK
global CMD
global STAT
global CFG
global KEYS
global USER_HOME

main(){
	Static init := main()

	USER_HOME := A_Desktop . "\..\.."
	
	CFG := new Config(".\ahkvimlike.ini")
	
	MARK := {}
	STAT := {}
	STAT["NORMAL"]   := CFG.get_sect("NORMAL")
	STAT["INSERT"]   := CFG.get_sect("INSERT")
	STAT["CAPSLOCK"] := CFG.get_sect("CAPSLOCK")

	KEYS := func_get_key_maps()

	CMD := new CmdOBJ("", "")
	CMD.changeMode("auto")
}

