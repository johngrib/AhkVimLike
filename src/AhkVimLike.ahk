/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#NoEnv
#SingleInstance
#NoTrayIcon
#Persistent
#include KeyMaps.ahk		; key define
#include ModeView.ahk		; change mode by Capslock state
#Include Utilities.ahk		; utility functions
#Include VimLike.ahk		; Vim like key setting
#Include Functions.ahk	; Mouse control functions
#include Space.ahk			; Space Key navigation
#include Commands.ahk	; Command functions

SendMode Input
SetDefaultMouseSpeed, 0 
SetKeyDelay, -1
SetMouseDelay, -1
SetWorkingDir %A_ScriptDir%

CapsLock & F5:: Reload
CapsLock & F4:: ExitApp

global MARK

main(){
	Static init := main()
	MARK := {}
}