/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

/* 
	for Korean Language Keyboard with Eclipse vrapper
	if 'ESC' or ':' press, switch to English 
*/
;#IfWinActive, ahk_class SWT_Window0
#If GetKeyState("capslock","T") = 0
	~Esc::
	~+SC027::
		if(IME_CHECK("A"))
			Send, {VK15}    ; input Korean/English switch key
	return
;#if
#IfWinActive

/* 
	Korean/English switch
*/
CapsLock & Space::Send, {VK15}

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