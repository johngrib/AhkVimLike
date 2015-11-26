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

global	memorized_0 := ""
global	memorized_1 := ""
global	memorized_2 := ""
global	memorized_3 := ""
global	memorized_4 := ""
global	memorized_5 := ""
global	memorized_6 := ""
global	memorized_7 := ""
global	memorized_8 := ""
global	memorized_9 := ""
