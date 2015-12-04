/*
  @Author : johngrib82@gmail.com
  @Created : 2015. NOV. 19
*/

/*  
  Capslock is mode changer in this program
  NORMAL   - Mode like VIM. (Arrow keys and Mouse controls)
  INSERT   - Normal key input mode.
  CAPSLOCK - Normal Capslock mode.
*/
CapsLock::
+Capslock::
  CMD.clear("num")
  if( GetKeyState("Capslock", "T") ){
    SetCapsLockState, Off
  } else {
    SetCapsLockState, On
  }
  if(GetKeyState("shift", "P")){
    CMD.changeMode("caps")
  } else {
    CMD.changeMode("auto")  
  }
  Send, {LShift up}
return

/*
  double click 'ESC' key to NORMAL mode
*/
#If GetKeyState("capslock","T") = 0
  $Esc::
    if (A_PriorHotKey = "$Esc" and A_TimeSincePriorHotKey < 500) {
      SetCapsLockState, On
      CMD.changeMode("auto")  
    } else {
      #IfWinActive, ahk_class SWT_Window0
        if(IME_CHECK("A"))
          Send, {VK15}    ; input Korean/English switch key
      #If
      SendInput {Esc}
    }
  return
#if

/*
  colon to input command mode
*/
#If GetKeyState("capslock","T")
  $+SC027::
    
    SetCapsLockState, Off
    CMD.changeMode("auto")
    
    ;Gui +LastFound +OwnDialogs +AlwaysOnTop
    
    title := "input_command"
    contents := ""
    
    InputBox, input_sentence, %title%, %contents%, ,300, 110
    
    ; if canceled, do nothing
    If ErrorLevel {
      SetCapsLockState, On
      CMD.clear("auto")
      return
    } 
    
    AUTO_TEMP := ""
    AUTO_CNT  := 1
    
    input_sentence := Trim(input_sentence)
    
    args := StrSplit(input_sentence, " ")
    args[0] := input_sentence
    
    if(args.Length() < 1){
      return
    }
    
    func_name := "command_" . args[1]   
    
    if( IsFunc( func_name ) ) {
      %func_name%(args)
    }
    SetCapsLockState, On
    CMD.clear("auto")
  return
#If

/*
  tab to auto complete in inputbox (input_command)
*/
#IfWinActive input_command
  $Tab::
  ControlGetText, txt, Edit1, input_command

  if(AUTO_TEMP = ""){
    AUTO_TEMP := Trim(txt)
    AUTO_CNT  := 1
    AUTO_ARR  := Object()
    reg := "^" . AUTO_TEMP
    
    arr := CFG.get_sect("INPUT_COMMAND")
    cnt := 0
    Loop % arr.MaxIndex()
    {
      th := arr[a_index]
      if(RegExMatch(th, reg)){
        cnt := cnt + 1
        AUTO_ARR.Insert(th)
      }
    }
    
    if(cnt > 0){
      result := AUTO_ARR[AUTO_CNT]
      ControlSetText, Edit1, %result%, input_command
      AUTO_CNT := AUTO_CNT + 1
      return
    }
  } else if( A_PriorKey = "Tab" ) {
    reg := "^" . AUTO_TEMP
    
    if(AUTO_ARR.MaxIndex() < AUTO_CNT){
      AUTO_CNT := 1
    }
    result := AUTO_ARR[AUTO_CNT]
    ControlSetText, Edit1, %result%, input_command
    AUTO_CNT := AUTO_CNT + 1
    return
  } else if( A_PriorKey <> "Tab" ) {
    AUTO_TEMP := ""
    return
  }
  return
#IfWinActive

/*
  number commands : numbers work like VIM
*/
$0::
$1::
$2::
$3::
$4::
$5::
$6::
$7::
$8::
$9::
  StringTrimLeft, num, A_ThisHotkey, StrLen(A_ThisHotkey) - 1

  if(RegExMatch(CMD.get_cmd(), "^\""\d{0,1}$")){
    CMD.append_cmd(num)
    show_mode(CMD.get_num_cmd())
    return
  }

  clear_str := { "m": "func_win_memorize", "'" :  "func_win_mem_activate" }
  if(clear_str.HasKey(CMD.get_cmd())) {
    function := clear_str[CMD.get_cmd()]
    %function%(num)
    CMD.clear("auto")
    return
  }

  CMD.append_num(num)

  if ( CMD.get_num() = "0" ) {
    key_0(CMD.get_num())
    CMD.clear("num")
    return
  }
  show_mode(CMD.get_num())
return

; shift + 4 : END key
$+4:: key_4(CMD.get_num())

/* 
  commands (joinable with number)
*/
$a::
$b::
$c::
$d::
$e::
$f::
$g::
;$h::
$i::
;$j::
;$k::
;$l::
$m::
$n::
$o::
$p::
$q::
$r::
$s::
$t::
$u::
$v::
$w::
$x::
$y::
$z::
;--------------
$+a::
$+b::
$+e::
$+i::
$+o::
$+q::
$+u::
$+x::
;--------------
$^b::
$^e::
$^f::
$^q::
;--------------
$SC028::   ;  '
$+SC028::  ; +'
  ; get hot_key
  hot_key := A_ThisHotkey
  
  if(A_ThisHotkey = "$SC028"){
    hot_key := "'"
  } else if(A_ThisHotkey = "$+SC028"){
    hot_key := """"
  } else if(RegExMatch(A_ThisHotkey, "^\W")){
    StringTrimLeft, hot_key, A_ThisHotkey, StrLen(A_ThisHotkey) - 1
  }
  
  ; join previous command with current command
  CMD.append_cmd(hot_key)
  
  ; if clipboard function
  if(RegExMatch(CMD.get_cmd(), "^\""[a-z]$")){
    show_mode(CMD.get_cmd())
    return
  } else if(RegExMatch(CMD.get_cmd(), "^\""(?:\+|\d+|[a-z])[yp]$")){
    register := RegExReplace(CMD.get_cmd(), "^\""(\+|\d+|[a-z])([yp])$", "$1,$2")
    rs := StrSplit(register, ",", ".")
    
    if(rs[2] = "p"){
      paste_from_clipboard_register(rs[1])
    } else {
      copy_to_clipboard_register(rs[1])
    }
    CMD.clear("auto")
    return
  }

  func_name := "key_" . CMD.get_cmd()
  clear_command := 0

  ; if command and function name matched, call function
  ; commands length should shorter than 3
  if( IsFunc( func_name) ) {
    clear_command := %func_name%(CMD.get_num())
    clear_command = 1
  } else if( 1 < StrLen(CMD.get_cmd())){
    clear_command = 1
  }

  if(clear_command = 1){
    CMD.clear("auto")
    return
  }

  show_mode(CMD.get_num_cmd())
return

/*
  mouse pointer accelator
  n + w a s d
  m + w a s d
  , + w a s d
*/
$SC01A::return  ;  [
$SC01B::return  ;  ]
$SC02B::return  ;  \

/*
  search
*/
$SC035::
  Send, ^{f}
  SetCapsLockState, Off
  CMD.changeMode("auto")
return

/*
  help
*/
$+SC035::Run, ".\manual.html"
  
/*
  h j k l moves
  h : left
  j : down
  k : up
  l : right
*/
#If GetKeyState("capslock","T") and StrLen(CMD.get_num()) < 1
    *h:: Left
    *j:: Down
    *k:: Up
    *l:: Right
#If
#If GetKeyState("capslock","T") and StrLen(CMD.get_num()) > 0
    *h:: func_hjkl_move("Left", CMD.get_num())
    *j:: func_hjkl_move("Down", CMD.get_num())
    *k:: func_hjkl_move("Up", CMD.get_num())
    *l:: func_hjkl_move("Right", CMD.get_num())
#If
func_hjkl_move(key, ByRef cnt){
  Send {%key% %cnt%}
  CMD.set_num("")
  CMD.changeMode("auto")
}