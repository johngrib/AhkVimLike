/*
	command functions : command_[a-z]+
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 25
*/

/*
	maximize active window
*/
command_max(args) {
	WinMaximize, A
}
/*
	minimize active window
*/
command_min(args) {
	WinMinimize, A
}

/*
	send ctrl + s
*/
command_w(args) {
	Send, ^s
}

/*
	adjust window invisibility 0 ~ 255
*/
command_trans(args){
	if(args.HasKey(2))
		option := args[2]
	else
		option := 35

	WinSet, Transparent, %option% , A
}

/*
	reset window inivisibility
*/
command_notrans(args){
	WinSet, Transparent, OFF, A
}

/*
	kill process (active window)
*/
command_kill(args){
	WinKill, A
}

/*
	get color at mouse pointer
*/
command_color(args){
	MouseGetPos, x, y
	PixelGetColor, rgb, x, y, RGB
	StringTrimLeft, rgb, rgb, 2
	InputBox, color, color, , , 300, 110, , , , , %rgb%
	Return	
}

/*
	shows list of memorized windows
*/
command_mark(args){
	msg := ""
	loop 10
	{
		num := A_Index - 1
		win_id := MARK[num]
		WinGetTitle, title, ahk_id %win_id%
		msg .= num . " : " . title . "`n"
	}
	MsgBox %msg%
}

/*
	edit script
*/
command_edit(args){
	Edit
}

/*
	show key log
*/
command_log(args){
	KeyHistory
}

/*
	show list of hot keys
*/
command_hotkey(args){
	ListHotkeys
}

/*
	get title text of active window
*/
command_title(args){
	WinGetActiveTitle, title
	InputBox, title, TITLE, , , 300, 110, , , , , %title%
}

/*
	get time/date string
*/
command_time(args){
	if(args.HasKey(2) and args[2] = "help"){
		Run, https://www.autohotkey.com/docs/commands/FormatTime.htm#Date_Formats_case_sensitive
		return
	}

	format_str := { "": "", "date" :  "yyyy.MM.d", "now" : "hh:mm:ss"}
	
	if(args.HasKey(2) and format_str.HasKey(args[2]))
		form := format_str[args[2]]
	else
		form := args[2]
	
	FormatTime, TimeString, ,%form%
	InputBox, time, time, , , 300, 110, , , , , %TimeString%
}

/*
	show variables list
*/
command_list(args){
	ListVars
}