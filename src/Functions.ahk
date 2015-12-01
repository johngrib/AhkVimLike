/*
  functions : func_[\w]+
  @Author   : johngrib82@gmail.com
  @Created  : 2015. NOV. 25
*/

func_get_key_maps(){
  ; numbers
  command_keymap := ["$0", "$1", "$2", "$3", "$4", "$+4", "$5", "$6", "$7", "$8", "$9"] 

  ; normal commands
  command_keymap.InsertAt(1, "$*i", "$*o",  "$z", "$x", "$+x", "$c", "$*g","$*t","$*r","$*b","$*f","$*q","$*e","$w","$a","$s","$d", "$m")

  ; mouse accelator   [  ]  \
  command_keymap.InsertAt(1, "$SC01A", "$SC01B",  "$SC02B")

  ; colon (+semi-colon) , single quote ( ' )
  command_keymap.InsertAt(1, "$+VKBF", "$SC028")

  return command_keymap
}

func_hjkl_move(key, ByRef cnt){
  Send {%key% %cnt%}
  CMD.set_num("")
  CMD.changeMode("auto")
}

/*
  mouse move
*/
func_mouse_move( ww, aa, ss, dd ) {
  ; mouse pointer move distance
  ; n + wasd : long distance
  ;     wasd : normal distance
  ; m + wasd : short distance
  ; , + wasd : 1 pixcel distance

  mul = 70
  ;if(1 == GetKeyState("n", "P")){
  if(GetKeyState("SC01A", "P")){    ;  [
    mul = 400
  } else if (GetKeyState("SC01B", "P")){   ;   ]
    mul = 10
  } else if (GetKeyState("SC02B", "P")){  ;  \
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
  mode change by i, o
*/
func_i_o() {
  SetCapsLockState, Off
  GetKeyState, isShiftDown, Shift, P
  CMD.changeMode("auto")
  
  if(GetKeyState("i", "P")){
    if("D" == isShiftDown) 
      Send, {Home}
  } else if(GetKeyState("o", "P")){
    if("D" == isShiftDown) 
      Send, {Up}
    Send, {End}{Enter}
  }
}

/*
  goto bookmarked window
*/
func_win_mem_activate(num){  
  win_id := MARK[num]
  WinActivate ahk_id %win_id%
  return
}

/*
  bookmark window
*/
func_win_memorize(num) {
  activeWin := WinExist("A")
  MARK[num] := activeWin
    return
}

/*
  shows mode on gui
*/
show_mode(msg){

  if(STAT.HasKey(msg))
    mode := msg
  else
    mode := "NORMAL"

  set := STAT[mode]
  
  bg_color := CFG.get_value(mode, "bg_color")
  font_color := CFG.get_value(mode, "font_color")
    xx := CFG.get_value("STAT_LOC", "x")
    yy := CFG.get_value("STAT_LOC", "y")

  create_gui("PANEL", set["_title"], msg, xx, yy, bg_color, font_color)
}

/*
  shows gui
*/
create_gui(id, title, msg, x, y, bg_color, font_color){
    Gui, %id%:Destroy
        Gui, %id%:+AlwaysOnTop +ToolWindow -Caption
    Gui, %id%:Color, %bg_color%
        Gui, %id%:Font, s9 bold, Verdana
        Gui, %id%:Add, Text, c%font_color%, -- %msg% --
        Gui, %id%:Show,NoActivate x%x% y%y%, %title%
    WinSet, Transparent, 220 , %title%
}

/*
  moves window to 1 2 3 4 5 6 7 8 9 location
*/
move_window(mon, var, title){

  key := "FENCE" . mon
  
  if(not CFG.has_sect(key))
    return
  
    top   := CFG.get_value(key, "y")
    left  := CFG.get_value(key, "x")
    width := CFG.get_value(key, "width")
    height:= CFG.get_value(key, "height")

    xx := left, ww := Floor(width / 2)
    yy := top,  hh := Floor(height / 2)

    if(var <= 3){
    yy := top + hh
    } else if(var <= 6){
    hh := height
    }
    
    if(2 = Mod(var, 3))    {
      ww := width
    } else if(0 = Mod(var, 3)) {
      xx := left + width / 2
    }

  WinMove, % title, , xx, yy, ww, hh
}