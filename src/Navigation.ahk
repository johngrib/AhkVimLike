/*
	h j k l moves
	h : left
	j : down
	k : up
	l : right
*/
#If GetKeyState("capslock","T") and StrLen(input_number) < 1
		*h:: Left
		*j:: Down
		*k:: Up
		*l:: Right
#If
#If GetKeyState("capslock","T") and StrLen(input_number) > 0
		*h:: hjkl_move("Left", input_number)
		*j:: hjkl_move("Down", input_number)
		*k:: hjkl_move("Up", input_number)
		*l:: hjkl_move("Right", input_number)
#If

hjkl_move(key, ByRef cnt){
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
	if(1 == GetKeyState("n", "P")){
		mul = 400
	} else if ( 1 == GetKeyState("m", "P")){
		mul = 10
	} else if ( 1 == GetKeyState("SC033", "P")){
		mul = 1
	}

	leftFlag  := GetKeyState("a", "P") * -1 * mul * aa
	rightFlag := GetKeyState("d", "P") * mul * dd
	upFlag  := GetKeyState("w", "P") * -1 * mul * ww
	downFlag := GetKeyState("s", "P") * mul * ss

	MouseMove, % leftFlag + rightFlag, upFlag + downFlag, 00, R
return
}