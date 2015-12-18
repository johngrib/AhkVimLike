/*
  @Author  : johngrib82@gmail.com
  @Created : 2015. NOV. 19
*/
#NoEnv
#SingleInstance
#NoTrayIcon
#Persistent
#include Config.ahk
#include KeyMaps.ahk    ; key define
#Include Utilities.ahk  ; utility functions
#Include VimLike.ahk    ; Vim like key setting
#Include Functions.ahk  ; Mouse control functions
#include Commands.ahk   ; Command functions
#include CmdOBJ.ahk
#include ClipOBJ.ahk

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
global A_UserHome
global AUTO_TEMP
global AUTO_CNT
global AUTO_ARR
global CLIP

main(){
  Static init := main()

  A_UserHome := A_Desktop . "\..\.."

  CFG := new Config(".\ahkvimlike.ini")
  CLIP := new ClipOBJ()

  MARK := {}
  STAT := {}
  STAT["NORMAL"]   := CFG.get_sect("NORMAL")
  STAT["INSERT"]   := CFG.get_sect("INSERT")
  STAT["CAPSLOCK"] := CFG.get_sect("CAPSLOCK")

  ;KEYS := func_get_key_maps()
  CMD  := new CmdOBJ("", "")
  AUTO_TEMP := ""
  AUTO_CNT  := 1
  AUTO_ARR  := Object()

  ; capslock state initialize
  caps := CFG.get_ini_value("INIT", "capslock", "off")  
  SetCapsLockState, %caps%
  CMD.changeMode("auto")
}