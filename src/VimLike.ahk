/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

/*
	number commands : numbers works like VIM
*/
$0::
$1::
$2::
$3::
$4::
$5::
$6::
$7::
$8::
$9::
	StringTrimLeft, hot_key, A_ThisHotkey, StrLen(A_ThisHotkey) - 1
	input_number := input_number . hot_key
	
	if ( input_number = "0" ) {
		key_0(input_number)
		input_number := ""
		return
	}
	showToolTip(input_number, 1000, 1000)
return

; shift + 4 : END key
$+4:: key_4(input_number)

$*i::
$*o::
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
return

	/* 
		commands (joinable with number)
	*/
	$*g::
	$*t::
	$*r::
	$*b::
	$*f::
	$*q::
	$*e::
	$*w::
	$*a::
	$*s::
	$*d::
	$*x::
		; get hot_key
		hot_key := A_ThisHotkey
		if(RegExMatch(A_ThisHotkey, "^\W")){
			StringTrimLeft, hot_key, A_ThisHotkey, StrLen(A_ThisHotkey) - 1
		}
		
		; join previous command with current command
		input_command := input_command . hot_key
		str := input_number . input_command
		func_name := "key_" . input_command
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

	$+SC027::	;  : (colon) command
		SetCapsLockState, Off
		changeMode("auto")
		
		title := "input command"
		contents := ""
		InputBox, input_sentence, %title%, %contents%, ,300, 110
		input_sentence := Trim(input_sentence)
		
		word_array1 := ""
		word_array2 := ""
		word_array3 := ""

		StringSplit, word_array, input_sentence, %A_Space%, .  ; Omits periods.

	func_name := "command_" . word_array1
		
		if( IsFunc( func_name) ) {
			%func_name%(word_array2)
		}

		SetCapsLockState, On
		input_number := ""
		input_command := ""
		changeMode("auto")
	return

/*
	mouse pointer accelator
	n + w a s d
	m + w a s d
	, + w a s d
*/
    $n::return
    $m::return
    $SC033::return
