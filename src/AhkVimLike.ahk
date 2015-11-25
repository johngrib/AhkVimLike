/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#NoEnv
#SingleInstance
#NoTrayIcon
#Persistent
#Include Controls.ahk		; exit/reload program
#include ModeView.ahk		; change mode by Capslock state
#Include Utilities.ahk		; utility functions
#Include VimLike.ahk		; Vim like key setting
#Include Navigation.ahk			; Mouse control functions
#include Space.ahk			; Space Key navigation
#include Commands.ahk	; Command functions

SendMode Input
SetDefaultMouseSpeed, 0 
SetKeyDelay, -1
SetMouseDelay, -1
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CapsLock & F5:: Reload
CapsLock & F4:: ExitApp

input_number = ""
input_command = ""

#if GetKeyState("capslock","T") 
	+VKBF::
		str = %A_ScriptDir%\manual.html
		Run, %str%
	return
#if