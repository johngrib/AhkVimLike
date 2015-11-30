/*
	key mapping functions : key_[a-z]+
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 26
*/
func_get_key_maps(){
	; numbers 
	command_keymap := ["$0", "$1", "$2", "$3", "$4", "$+4", "$5", "$6", "$7", "$8", "$9"] 

	; normal commands
	command_keymap.InsertAt(1, "$*i", "$*o",  "$z", "$x", "$c", "$*g","$*t","$*r","$*b","$*f","$*q","$*e","$w","$a","$s","$d", "$m")

	; mouse accelator 	[  ]  \
	command_keymap.InsertAt(1, "$SC01A", "$SC01B",  "$SC02B")

	; colon (+semi-colon) , single quote ( ' )
	command_keymap.InsertAt(1, "$+VKBF", "$SC028")

	return command_keymap
}

/*
	x, +x : delete, backspace
*/
key_x(ByRef input_number){
	if(GetKeyState("Control"))
		Send, ^{x}
	else if(GetKeyState("Shift"))
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
	if( GetKeyState("Control"))
		Click Down Left
	else if( GetKeyState("Shift"))
		Click Up Left
	else if( GetKeyState("Space", "p"))
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
	if( GetKeyState("Control") )
		Click Down Right
	else if( GetKeyState("Shift") )
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
	func_mouse_move( input_number , 1, 1, 1 )
}
key_a(ByRef input_number) {
	func_mouse_move( 1, input_number, 1, 1 )
}
key_s(ByRef input_number) {
	func_mouse_move( 1, 1, input_number, 1 )
}
key_d(ByRef input_number) {
	func_mouse_move( 1, 1, 1, input_number )
}

/*
	H J K L move
*/
/*
key_h(ByRef input_number) {
	Send {Left %input_number%}
}
key_j(ByRef input_number) {
	Send {Down %input_number%}
}
key_k(ByRef input_number) {
	Send {Up %input_number%}
}
key_l(ByRef input_number) {
	Send {Right %input_number%}
}
*/

/*
	tab move
*/
key_gt(ByRef input_number) {
	Send, ^{PGDN %input_number%}
}
key_gr(ByRef input_number) {
	Send, ^{PGUP %input_number%}
}

key_gq(ByRef input_number){
	MouseMove, 2, 0
}

key_gw(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, ww/2, 0
}

key_ge(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, ww - 2, 0
}

key_ga(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, 2, hh/2	
}

key_gs(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, ww/2, hh/2	
}
	
key_gd(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, ww - 2, hh/2	
}

key_gz(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, 2, hh - 2	
}

key_gx(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, ww/2, hh - 2
}
	
key_gc(ByRef input_number){
	WinGet, winid ,, A
	WinGetActiveStats, winid, ww, hh, xx, yy
	MouseMove, ww -2, hh - 2 
}

key_t(ByRef input_number){
}
key_c(ByRef input_number){
}

/*
	window move
*/
key_zq(ByRef input_number){
	move_window(7, "A")
}
key_zw(ByRef input_number){
	move_window(8, "A")
}
key_ze(ByRef input_number){
	move_window(9, "A")
}
key_za(ByRef input_number){
	move_window(4, "A")
}
key_zs(ByRef input_number){
	move_window(5, "A")
}
key_zd(ByRef input_number){
	move_window(6, "A")
}
key_zz(ByRef input_number){
	move_window(1, "A")
}
key_zx(ByRef input_number){
	move_window(2, "A")
}
key_zc(ByRef input_number){
	move_window(3, "A")
}