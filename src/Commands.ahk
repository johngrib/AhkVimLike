/*
	minimize active window
*/
command_min(option) {
	WinMinimize, A
}

/*
	maximize active window
*/
command_max(option) {
	WinMaximize, A
}

/*
	send ctrl + s
*/
command_w(option) {
	Send, ^s
}

/*
	adjust window invisibility 0 ~ 255
*/
command_trans(option){
	if(option = "") 
		option := 35

	WinSet, Transparent, %option% , A
}

/*
	reset window inivisibility
*/
command_notrans(option){
	WinSet, Transparent, OFF, A
}

/*
	kill process (active window)
*/
command_kill(option){
	WinKill, A
}

/*
	always on top (toggle)
*/
command_top(option){
	WinSet, AlwaysOnTop, Toggle, A
}

/*
	get color at mouse pointer
*/
command_color(option){
	MouseGetPos,x,y
	PixelGetColor,rgb,x,y,RGB
	StringTrimLeft,rgb,rgb,2
	Clipboard=%rgb%
	Return	
}