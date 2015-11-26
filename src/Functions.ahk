/*
	functions : func_[\w]+
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 25
*/
func_hjkl_move(key, ByRef cnt){
	Send {%key% %cnt%}
	cnt := ""
	changeMode("auto")
}



func_mouse_move( ww, aa, ss, dd ) {
	; mouse pointer move distance
	; n + wasd : long distance
	;     wasd : normal distance
	; m + wasd : short distance
	; , + wasd : 1 pixcel distance

	mul = 70
	;if(1 == GetKeyState("n", "P")){
	if(GetKeyState("SC01A", "P")){		;  [
		mul = 400
	} else if (GetKeyState("SC01B", "P")){   ;   ]
		mul = 10
	} else if (GetKeyState("SC02B", "P")){	;  \
		mul = 1
	}

	leftFlag  := GetKeyState("a", "P") * -1 * mul * aa
	rightFlag := GetKeyState("d", "P") * mul * dd
	upFlag  := GetKeyState("w", "P") * -1 * mul * ww
	downFlag := GetKeyState("s", "P") * mul * ss

	MouseMove, % leftFlag + rightFlag, upFlag + downFlag, 00, R
return
}


func_i_o() {
	SetCapsLockState, Off
	GetKeyState, isShiftDown, Shift, P
	changeMode("auto")
	
	if(GetKeyState("i", "P")){
		if("D" == isShiftDown) 
			Send, {Home}
	} else if(GetKeyState("o", "P")){
		if("D" == isShiftDown) 
			Send, {Up}
		Send, {End}{Enter}
	}
}

func_win_mem_activate(num){
	win_id := memorized_%num%
	WinActivate ahk_id %win_id%
	return
}

func_win_memorize(num) {	
	activeWin := WinExist("A")
	memorized_%num% := activeWin
    return	
}