func_get_key_maps(){
	; numbers 
	command_keymap := ["$0", "$1", "$2", "$3", "$4", "$+4", "$5", "$6", "$7", "$8", "$9"] 

	; normal commands
	command_keymap.InsertAt(1, "$*i", "$*o",  "$*x", "$*g","$*t","$*r","$*b","$*f","$*q","$*e","$*w","$*a","$*s","$*d")

	; mouse accelator
	command_keymap.InsertAt(1, "$n", "$m",  "$SC033")

	;  colon
	command_keymap.InsertAt(1, "$+SC027")

	return command_keymap
}

/*
	x, +x : delete, backspace
*/
key_x(ByRef input_number){
	if(GetKeyState("Shift"))
		Send, {BackSpace %input_number%}
	else if(input_number <> "")
		Send, {Delete %input_number%}
}

/*
	0 : Home
*/
key_0(ByRef input_number) {
	Send, {Home}	
}
/*
	$ : End
*/
key_4(ByRef input_number) {
	if(GetKeyState("shift", "P"))
		Send, {End}
}

/*
	r : Mouse Wheel Up
*/
key_r(ByRef input_number) {
	MouseClick, WheelUp, , , input_number
}

/*
	f  : Mouse Wheel Down
	^f : Page Down
*/
key_f(ByRef input_number) {
	if( GetKeyState("Control") = 1)
		Send, {PGDN %input_number%}
	else
		MouseClick, WheelDown, , , input_number
}

/*
	^b : Page Up
*/
key_b(ByRef input_number) {
	if( GetKeyState("Control") = 1)
		Send, {PGUP %input_number%}
}

/*
	q : Click Mouse Left Button
	^q : Click Hold
	+q : unHold
*/
key_q(ByRef input_number) {
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
key_e(ByRef input_number) {
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
key_w(ByRef input_number) {
	if(input_number = "") 
		input_number := 1
	func_mouse_move( input_number , 1, 1, 1 )
}
key_a(ByRef input_number) {
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, input_number, 1, 1 )
}
key_s(ByRef input_number) {
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, 1, input_number, 1 )
}
key_d(ByRef input_number) {
	if(input_number = "")
		input_number := 1
	func_mouse_move( 1, 1, 1, input_number )
}

/*
	tab move
*/
key_gt(ByRef input_number) {
	Send, ^{PGDN %input_number%}
}
key_gr(ByRef input_number) {
	Send, ^{PGUP %input_number%}
}