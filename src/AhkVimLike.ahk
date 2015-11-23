/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#NoEnv
#SingleInstance 
#Persistent
#Include Controls.ahk		; exit/reload program
#include ModeView.ahk		; change mode by Capslock state
#Include Utilities.ahk		; utility functions
#Include VimLike.ahk		; Vim like key setting
#Include Navigation.ahk			; Mouse control functions
#include Space.ahk			; Space Key navigation

SetDefaultMouseSpeed, 0 
SetKeyDelay, -1
SetMouseDelay, -1

input_number = ""
input_command = ""