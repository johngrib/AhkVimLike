/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#if GetKeyState("capslock","T")	

    ; control mouse moving speed
    ;'$Space::return
    $n::return
    $m::return
    SC033::return

#if

/*
	Mouse Wheel Up & Down
*/
func_r(ByRef input_number)
{
	MouseClick, WheelUp, , , input_number
}
func_f(ByRef input_number)
{
	if( GetKeyState("Control") = 1){
		Send, {PGDN %input_number%}
	} else {
		MouseClick, WheelDown, , , input_number
	}
}

/*
	Control Mouse Left Button
*/
func_q(ByRef input_number)
{
	if( GetKeyState("Space", "p") = 1){
		MouseMove, 0, 0
		return
	}	

	if( GetKeyState("Control") = 1){
		Click Down Left
	} else if( GetKeyState("Shift") = 1){
		Click Up Left
	} else if( GetKeyState("Space", "p") = 1){
		MouseMove, 5, 5
	} else {
		Click, Left, %input_number%
	} 
}

/*
	Control Mouse Right Button
*/
func_e(ByRef input_number)
{
		if( GetKeyState("Control") = 1){
		Click Down Right
	} else if( GetKeyState("Shift") = 1){
		Click Up Right
	} else {
		Click, Right, %input_number%		
	}
}

/*
	Control Mouse Pointer movement By w a s d
*/
func_w(ByRef input_number)
{
	if(input_number = "") 
		input_number := 1
	func_mouse_move( input_number , 1, 1, 1 )
}
func_a(ByRef input_number)
{
	if( GetKeyState("Space", "p") = 1){
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, 0, hh/2
		return
	}
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, input_number, 1, 1 )
}
func_s(ByRef input_number)
{
	if( GetKeyState("Space", "p") = 1){
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww/2, hh/2
		return
	}
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, 1, input_number, 1 )
}
func_d(ByRef input_number)
{
	if( GetKeyState("Space", "p") = 1){
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww - 2, hh/2
		return
	}
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, 1, 1, input_number )
}

func_mouse_move( ww, aa, ss, dd )
{
	; mouse pointer move distance
	; n + wasd : long distance
	;     wasd : normal distance
	; m + wasd : short distance
	; , + wasd : 1 pixcel distance

	mul = 70
	if(1 == GetKeyState("n", "P")){
		mul = 400
	} else if ( 1 == GetKeyState("m", "P")){
		mul = 10
	} else if ( 1 == GetKeyState("SC033", "P")){
		mul = 1
	}
	leftFlag := GetKeyState("a", "P") * -1 * mul * aa
	rightFlag := GetKeyState("d", "P") * mul * dd
	upFlag := GetKeyState("w", "P") * -1 * mul * ww
	downFlag := GetKeyState("s", "P") * mul * ss

	MouseMove, % leftFlag + rightFlag, upFlag + downFlag, 00, R
return
}