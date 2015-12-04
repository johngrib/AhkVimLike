/*
  command functions : command_[a-z]+
  @Author  : johngrib82@gmail.com
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

/*
  open everything
*/
command_run(args){
  txt := args[2]
  run %txt%
}

/*
  open keywords
  Canonical Names of Control Panel Items
  @link https://msdn.microsoft.com/en-us/library/ee330741%28VS.85%29.aspx
*/
command_op(args){

  sect := CFG.get_sect("OP_ADDRESS")

  if(sect.HasKey(args[2])){
    value := sect[args[2]]
    page := args[3]
    sentence := Trim(value . " " . page)
    Run, %sentence%
  }
}
command_open(args){
  command_op(args)
}

/*
  show clipboard register
*/
command_reg(args){
  rs := CLIP.get_list()
  MsgBox % rs
}

/*
  adjust invisivility of status bar
*/
command_stattrans(args){
  
  if(not RegExMatch(args[2], "^\d{1,3}$"))
    return
  
  if(args[2] < 0)
    args[2] := 0
  else if(args[2] > 255)
    args[2] := 255
  
  CFG.get_sect("NORMAL")["trans"] := args[2]
  CFG.get_sect("INSERT")["trans"] := args[2]
  CFG.get_sect("CAPSLOCK")["trans"] := args[2]
  
  CFG.fix_ini_value("NORMAL", "trans", args[2] )
  CFG.fix_ini_value("INSERT", "trans", args[2] )
  CFG.fix_ini_value("CAPSLOCK", "trans", args[2] )
}