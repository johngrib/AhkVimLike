/*
  @Author : johngrib82@gmail.com
  @Created : 2015. NOV. 19
*/

/* 
  Korean/English switch
*/
CapsLock & Space::Send, {VK15}
CapsLock & t::WinSet, AlwaysOnTop, Toggle, A

#If WinExist("avl_insert") or  WinExist("avl_capslock")
  ~+SC027::
    if(IME_CHECK("A"))
      Send, {VK15}    ; input Korean/English switch key
  return
#if

#If not WinActive("ahk_class XLMAIN")
  +Space:: Send, {VK15}    ; input Korean/English switch key
#IF

/*
  ^c -> push to clipboard register
*/
~^c::
  Sleep 500
  new_value := Clipboard
  CLIP.num_unshift(new_value)
return

/*
  use ^v on ms cmd.com console.
*/
#IfWinActive ahk_class ConsoleWindowClass 
	^V:: 
		SendInput {Raw}%clipboard% 
	return 
#IfWinActive

/*
  IME check (MS Windows Korean character input mode check)
*/
IME_CHECK(WinTitle) {
  WinGet,hWnd,ID,%WinTitle%
  Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}
Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
  DetectSave := A_DetectHiddenWindows    
  DetectHiddenWindows,ON
   SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
  if (DetectSave <> A_DetectHiddenWindows)
      DetectHiddenWindows,%DetectSave%
  return ErrorLevel
}
ImmGetDefaultIMEWnd(hWnd) {
  return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}