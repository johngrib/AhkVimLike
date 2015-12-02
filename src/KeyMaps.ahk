/*
  key mapping functions : key_[a-z]+
  @Author : johngrib82@gmail.com
  @Created : 2015. NOV. 26
*/

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
  u : undo
*/
key_u(ByRef input_number){
  if(input_number <> "")
    Send, ^{z %input_number%}
}

/*
  to upper case , to lower case
*/
key_gu(ByRef input_number){
  
  old := ClipboardAll
  Clipboard := ""
  Send, ^c

  ClipWait 0.5
  if (ErrorLevel){
    Clipboard := old
    return
  }

  if( GetKeyState("Shift") ){
    StringUpper, Clipboard, Clipboard    
  } else {
    StringLower, Clipboard, Clipboard
  }
  
  Send, ^v
  Clipboard := old
  return
}

/*
  copy
*/
key_y(ByRef input_number){
  temp := Clipboard
  Send, ^{c}
  Sleep 500
  
  if(input_number = ""){
    CLIP.num_unshift(Clipboard)
  } else {
    CLIP.set_value(input_number, Clipboard)
  }
  Clipboard := temp
}

~^c::
  Sleep 500
  new_value := Clipboard
  CLIP.num_unshift(new_value)
return


/*
  paste
*/
key_p(ByRef input_number){
  Send, ^{v %input_number%}
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
  if( GetKeyState("Control") )
    Send, {PGDN %input_number%}
  else
    MouseClick, WheelDown, , , input_number
}

/*
  ^b : Page Up
*/
key_b(ByRef input_number) {
  if( GetKeyState("Control") )
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
  if(input_number = "")
    input_number = 1
  func_mouse_move( input_number , 1, 1, 1 )
}
key_a(ByRef input_number) {
  if(input_number = "")
    input_number = 1
  func_mouse_move( 1, input_number, 1, 1 )
}
key_s(ByRef input_number) {
  if(input_number = "")
    input_number = 1
  func_mouse_move( 1, 1, input_number, 1 )
}
key_d(ByRef input_number) {
  if(input_number = "")
    input_number = 1
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
  move_window(input_number, 7, "A")
}
key_zw(ByRef input_number){
  move_window(input_number, 8, "A")
}
key_ze(ByRef input_number){
  move_window(input_number, 9, "A")
}
key_za(ByRef input_number){
  move_window(input_number, 4, "A")
}
key_zs(ByRef input_number){
  move_window(input_number, 5, "A")
}
key_zd(ByRef input_number){
  move_window(input_number, 6, "A")
}
key_zz(ByRef input_number){
  move_window(input_number, 1, "A")
}
key_zx(ByRef input_number){
  move_window(input_number, 2, "A")
}
key_zc(ByRef input_number){
  move_window(input_number, 3, "A")
}