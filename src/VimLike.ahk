/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

/*	
	Capslock is mode changer in this program
	command  - Mode like VIM. (Arrow keys and Mouse controls)
	insert   - Normal key input mode.
	capslock - Normal Capslock mode.
*/
CapsLock::
+Capslock::
	CMD.clear("num")
	if( GetKeyState("Capslock", "T") ){
		SetCapsLockState, Off
	} else {
		SetCapsLockState, On
	}
	if(GetKeyState("shift", "P")){
		CMD.changeMode("caps")
	} else {
		CMD.changeMode("auto")	
	}
	Send, {LShift up}
return

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
	StringTrimLeft, num, A_ThisHotkey, StrLen(A_ThisHotkey) - 1

	clear_str := { "m": "func_win_memorize", "'" :  "func_win_mem_activate" }
	if(clear_str.HasKey(CMD.get_cmd())) {
		function := clear_str[CMD.get_cmd()]
		%function%(num)
		CMD.clear("auto")
		return
	}

	CMD.append_num(num)

	if ( CMD.get_num() = "0" ) {
		key_0(CMD.get_num())
		CMD.clear("num")
		return
	}
    show_mode(CMD.get_num())
return

; shift + 4 : END key
$+4:: key_4(CMD.get_num())

$*i::
$*o::
	func_i_o()
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
	$w::
	$a::
	$s::
	$d::
	$*z::
	$*x::
	$*c::
	$m::
	$SC028::  ;  '
		; get hot_key
		hot_key := A_ThisHotkey
		
		if(A_ThisHotkey = "$SC028"){
			hot_key := "'"
		} else if(RegExMatch(A_ThisHotkey, "^\W")){
			StringTrimLeft, hot_key, A_ThisHotkey, StrLen(A_ThisHotkey) - 1
		}
		
		; join previous command with current command
		CMD.append_cmd(hot_key)
		func_name := "key_" . CMD.get_cmd()
		clear_command := 0

		; if command and function name matched, call function
		; commands length should shorter than 3
		if( IsFunc( func_name) ) {

			if(CMD.get_num() = "")
				CMD.set_num("1")

			clear_command := %func_name%(CMD.get_num())
			clear_command = 1
		} else if( 2 < StrLen(CMD.get_cmd())){
			clear_command = 1
		}

		if(clear_command = 1){
			CMD.clear("auto")
			return
		}

        show_mode(CMD.get_num_cmd())
	return

	$+SC027::	;  : (colon) command
		SetCapsLockState, Off
		CMD.changeMode("auto")
		
		title := "input command"
		contents := ""
		InputBox, input_sentence, %title%, %contents%, ,300, 110
		input_sentence := Trim(input_sentence)

		args := StrSplit(input_sentence, " ")

		if(args.Length() < 1){
			return
		}
		func_name := "command_" . args[1]
		
		if( IsFunc( func_name ) ) {
			%func_name%(args)
		}

		SetCapsLockState, On
		CMD.clear("auto")
	return

/*
	mouse pointer accelator
	n + w a s d
	m + w a s d
	, + w a s d
*/
    $SC01A::return	;  [
    $SC01B::return	;  ]
    $SC02B::return	;  \

/*
	help
*/
	$+VKBF::Run, ".\manual.html"
	
	/*
	h j k l moves
	h : left
	j : down
	k : up
	l : right
*/
#If GetKeyState("capslock","T") and StrLen(CMD.get_num()) < 1
		*h:: Left
		*j:: Down
		*k:: Up
		*l:: Right
#If
#If GetKeyState("capslock","T") and StrLen(CMD.get_num()) > 0
		*h:: func_hjkl_move("Left", CMD.get_num())
		*j:: func_hjkl_move("Down", CMD.get_num())
		*k:: func_hjkl_move("Up", CMD.get_num())
		*l:: func_hjkl_move("Right", CMD.get_num())
#If