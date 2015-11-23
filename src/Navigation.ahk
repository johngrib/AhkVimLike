/*
	Mouse and Keyboard navigation
	
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

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

/*
	mouse pointer accelator
	n + w a s d
	m + w a s d
	, + w a s d
*/
#if GetKeyState("capslock","T")	
    $n::return
    $m::return
    SC033::return
#if

/*
	0 : Home
*/
func_0(ByRef input_number) {
	Send, {Home}	
}
/*
	$ : End
*/
func_4(ByRef input_number) {
	if(GetKeyState("shift", "P"))
		Send, {End}
}

/*
	r : Mouse Wheel Up
*/
func_r(ByRef input_number) {
	MouseClick, WheelUp, , , input_number
}

/*
	f  : Mouse Wheel Down
	^f : Page Down
*/
func_f(ByRef input_number) {
	if( GetKeyState("Control") = 1)
		Send, {PGDN %input_number%}
	else
		MouseClick, WheelDown, , , input_number
}

/*
	^b : Page Up
*/
func_b(ByRef input_number) {
	if( GetKeyState("Control") = 1)
		Send, {PGUP %input_number%}
}

/*
	q : Click Mouse Left Button
	^q : Click Hold
	+q : unHold
*/
func_q(ByRef input_number) {
	if( GetKeyState("Control") = 1)
		Click Down Left
	else if( GetKeyState("Shift") = 1)
		Click Up Left
	else if( GetKeyState("Space", "p") = 1)
		MouseMove, 5, 5
	else
		Click, Left, %input_number%
}

/*
	e : Click Mouse Right Button
	^e : Click Hold
	+e : unHold
*/
func_e(ByRef input_number) {
	if( GetKeyState("Control") = 1)
		Click Down Right
	else if( GetKeyState("Shift") = 1)
		Click Up Right
	else
		Click, Right, %input_number%
}

/*
	Control Mouse Pointer movement By w a s d
	w : up
	a : left
	s : down
	d : right
*/
func_w(ByRef input_number) {
	if(input_number = "") 
		input_number := 1
	func_mouse_move( input_number , 1, 1, 1 )
}
func_a(ByRef input_number) {
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, input_number, 1, 1 )
}
func_s(ByRef input_number) {
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, 1, input_number, 1 )
}
func_d(ByRef input_number) {
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, 1, 1, input_number )
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

/*
	tab move
*/
func_gt(ByRef input_number) {
	Send, ^{PGDN %input_number%}
}
func_gr(ByRef input_number) {
	Send, ^{PGUP %input_number%}
}