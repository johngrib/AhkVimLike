/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

#if GetKeyState("capslock","T")	
	/*
		number commands : numbers works like VIM
	*/
		0::
		1::
		2::
		3::
		4::
		5::
		6::
		7::
		8::
		9::
			input_number := input_number . A_ThisHotkey
			
			if ( input_number = "0" ) {
				func_0(input_number)
				input_number := ""
				return
			}
			showToolTip(input_number, 1000, 1000)
		return

		; shift + 4 : END key
		+4:: func_4(input_number)

	*i::
	*o::
		SetCapsLockState, Off
		GetKeyState, isShiftDown, Shift, P
		changeMode("auto")
		if(A_ThisHotkey == "*i"){
			if("D" == isShiftDown) 
				Send, {Home}
		} else if (A_ThisHotkey == "*o"){
			if("D" == isShiftDown) 
				Send, {Up}
			Send, {End}{Enter}
		}
	return

	/* 
		commands (joinable with number)
	*/
	g::	; gt (next tab), gr (previous tab) 
	t::		; gt (next tab)
	r::		; gr (previous tab), r (mouse wheel up)
	f::		; mouse wheel down
	^f::	; page_down : vim_like
	^q::	; hold click mouse left button
	+q:: ; unhold click mouse left button
	q::	; click mouse left button
	^e::	; hold click mouse right button
	+e::	; unhold click mouse right button
	e::	; click mouse right button
	$w::	; move mouse pointer up
	$a::	; move mouse pointer left
	$s::	; move mouse pointer down
	$d::	; move mouse pointer right

		; get hot_key
		hot_key := A_ThisHotkey
		if(RegExMatch(A_ThisHotkey, "^\W")){
			StringTrimLeft, hot_key, A_ThisHotkey, StrLen(A_ThisHotkey) - 1
		}
		
		; join previous command with current command
		input_command := input_command . hot_key
		str := input_number . input_command
		func_name := "func_" . input_command
		clear_command := 0

		; if command and function name matched, call function
		; commands length should shorter than 4
		if( IsFunc( func_name) ) {
			%func_name%(input_number)
			clear_command = 1
		} else if( 3 < StrLen(input_command)){
			clear_command = 1
		}
		
		if(clear_command = 1){
			input_number := ""
			input_command := ""
			changeMode("auto")
			return
		}
		showToolTip(str, 1000, 1000)
	return
#if

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

/*
	functions
*/
hjkl_move(key, ByRef cnt){
	Send {%key% %cnt%}
	cnt := ""
	changeMode("auto")
}
 
/*
	tab move
*/
func_gt(ByRef input_number)
{
	Send, ^{PGDN %input_number%}
}
func_gr(ByRef input_number)
{
	Send, ^{PGUP %input_number%}
}
func_0(ByRef input_number)
{
	Send, {Home}	
}
func_4(ByRef input_number)
{
	if(1 == GetKeyState("shift", "P")){
		Send, {End}
	}
}