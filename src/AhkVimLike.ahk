/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#NoEnv
#SingleInstance
#NoTrayIcon
#Persistent
#include KeyMaps.ahk		; key define
#Include Utilities.ahk		; utility functions
#Include VimLike.ahk		; Vim like key setting
#Include Functions.ahk	; Mouse control functions
#include Space.ahk			; Space Key navigation
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
global VAR

main(){
	Static init := main()
	MARK := {}
	VAR := {}
	VAR["NORMAL"] := {"title": "avl_normal", "bg_color": "000000", "font_color": "FF0000" }
	VAR["INSERT"] := {"title": "avl_insert", "bg_color": "3F51B5", "font_color": "FFFFFF" }
	VAR["CAPSLOCK"] := {"title": "avl_capslock", "bg_color": "FF4081", "font_color": "FFFFFF" }
	
	CMD := new CmdOBJ("", "")
	CMD.changeMode("auto")
}