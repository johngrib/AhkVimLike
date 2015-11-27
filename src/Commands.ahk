/*
	command functions : command_[a-z]+
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 25
*/

/*
	maximize active window
*/
command_max(option) {
	WinMaximize, A
}
/*
	minimize active window
*/
command_min(option) {
	WinMinimize, A
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
	get color at mouse pointer
*/
command_color(option){
	MouseGetPos,x,y
	PixelGetColor,rgb,x,y,RGB
	StringTrimLeft,rgb,rgb,2
	Clipboard=%rgb%
	Return	
}

/*
	shows list of memorized windows
*/
command_mark(option){
	msg := ""
	loop 10
	{
		num = %A_Index%
		num -= 1
		win_id := memorized_%num%
		
		WinGetTitle, title, ahk_id %win_id%
		
		msg .= num . " : "
		msg .= title
		msg .= "`n"
	}
	MsgBox %msg%
}

/*
	edit script
*/
command_edit(option){
	Edit
}

/*
	show key log
*/
command_log(option){
	KeyHistory
}

/*
	show list of hot keys
*/
command_hotkey(option){
	ListHotkeys
}

/*
	get title text of active window
*/
command_title(option){
	WinGetActiveTitle, title
	InputBox, title, TITLE, , , 300, 110, , , , , %title%
}

/*
	get time/date string
*/
command_time(option){
	if(option = "help"){
		Run, https://www.autohotkey.com/docs/commands/FormatTime.htm#Date_Formats_case_sensitive
		return
	}
	
	if(option = ""){
		FormatTime, TimeString
	} else if(option = "date"){
		;FormatTime, TimeString, , dddd MMMM d, yyyy hh:mm:ss tt
		FormatTime, TimeString, ,yyyy.MM.d
	} else if(option = "now"){
		FormatTime, TimeString, ,hh:mm:ss
	} else {
		FormatTime, TimeString, ,%option%
	}
	InputBox, time, time, , , 300, 110, , , , , %TimeString%
}