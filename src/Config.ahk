class Config {
  
  /*
    Contructor
  */
  __New(file_address) {
    this.file_address := file_address
    
    this.cfg := {}
    this.set_stat_color()
    this.set_multi_monitor_location()
   
    this.cfg["STAT_LOC"]    := this.func_get_stat_location()
    this.cfg["OP_ADDRESS"]  := this.get_ini_section("OP_ADDRESS")
    this.cfg["INPUT_COMMAND"] := this.get_input_command()   
  } ; // end of __New

  get_input_command(){

    str := ""
    file := this.file_address
    IniRead,se, %file%, INPUT_COMMAND
    Loop,Parse,se,`n,`r  
    {
      line := Trim(A_LoopField)
      str := str . "," . line
    }
    
    enum := this.cfg["OP_ADDRESS"]._NewEnum()
    While enum[k, v]
    {
      temp := ",op " . k
      str := str . temp
    }
    str := SubStr(str, 2)
    Sort, str, CL D,
    return StrSplit(str, ",", ".")    
  }

  set_stat_color(){
    this.cfg["NORMAL"]   := {"font_color" : "FF0000", "bg_color" : "000000", "_title": "avl_normal", "trans": "220" }
    this.cfg["INSERT"]   := {"font_color" : "3F51B5", "bg_color" : "FFFFFF", "_title": "avl_insert", "trans": "220"  }
    this.cfg["CAPSLOCK"] := {"font_color" : "FF4081", "bg_color" : "FFFFFF", "_title": "avl_capslock", "trans": "220" }

    for sect, obj in this.cfg {
      for key, def in obj {
        ini_value := this.get_ini_value(sect, key, def)
        if(this.is_invalid_value(key, ini_value)){
          ini_value := this.fix_ini_value( sect, key, this.cfg[sect][key] )
        }        
        this.cfg[sect][key] := ini_value
      }
    }    
  }

  set_multi_monitor_location(){
    this.cfg["MONITOR_CNT"] := this.get_monitor_cnt()
    cnt := this.cfg["MONITOR_CNT"]
    loop %cnt% {
      SysGet, mon, Monitor, %A_Index%
      name := "FENCE" . A_Index
      this.cfg[name] := {"loc" : "down", "size" : 0, "width" : monRight - monLeft, "height" : monBottom - monTop, "x" : monLeft, "y" : monTop }
    }
    this.cfg["FENCE"]       := this.func_get_tray_location()    
  }

  get_ini_section(sect){
    map := {}
    file := this.file_address
    IniRead,se, %file%, %sect%
    Loop,Parse,se,`n,`r  
    {
      line := Trim(A_LoopField)
      if(RegExMatch(line, "^\s*\w+\s*\=\s*.+$")) {
        key := RegExReplace(A_LoopField, "^\s*(\w+)\s*\=\s*.+$", "$1")
        val := RegExReplace(A_LoopField, "^\s*\w+\s*\=\s*(.+)$", "$1")
        map[key] := val
      }
    }
    return map
  }
  
  /*
    get monitor count
  */
  get_monitor_cnt(){
    SysGet, cnt, MonitorCount
    return cnt
  }
  
  /*
    check config section
  */
  has_sect(str){
    return this.cfg.HasKey(str)
  }
  
  /*
    get section config
  */
  get_sect(str){
    return this.cfg[str]
  }

  /*
    get section-key value
  */
  get_value(sect, key){
    return this.cfg[sect][key]
  }
  
  /*
    get value from ini file
  */
  get_ini_value(sect, key, default_value){
    file := this.file_address
    IniRead, value, %file%, %sect%, %key%, %default_value%
    return value
  }
  
  /*
    ini value validate check 
  */
  is_invalid_value( key, value ) {
    if(RegExMatch( key , "^_"))
      return false
    
    if( RegExMatch( key, "^[^_]+_color$" ) )
       return not RegExMatch( value, "^[0-9a-fA-F]{6}$" )
  }

  /*
    fix unvalid value in ini file
  */
  fix_ini_value( sect, key, value ){
    file := this.file_address
    IniWrite, %value%, %file%, %sect%, %key%
    return value
  }
  
  /*
    
  */
  func_get_stat_location(){
    tray_info := this.cfg["FENCE"]
    loc := tray_info["loc"]
    size := tray_info["size"]

    height := this.get_stat_height()
    if( loc = "down" )
      return {"x" : Floor(A_ScreenWidth/2), "y" : A_ScreenHeight - size - height }
    else
      return {"x" : Floor(A_ScreenWidth/2), "y" : A_ScreenHeight - height }
  }
  func_get_tray_location(){
    WinGetPos,xx,yy,ww,hh,ahk_class Shell_TrayWnd,,,
    if( ww > hh and yy > 0 )
      return {"loc" : "down", "size" : hh, "width" : A_ScreenWidth, "height" : A_ScreenHeight - hh, "x" : 0, "y" : 0 }
    else if( ww < hh and yy = 0 and xx = 0)
      return {"loc" : "left", "size" : hh, "width" : A_ScreenWidth - ww, "height" : A_ScreenHeight, "x" : ww, "y" : 0 }
    else if( ww < hh and xx > 0 )
      return {"loc" : "right", "size" : hh, "width" : A_ScreenWidth - ww, "height" : A_ScreenHeight, "x" : 0, "y" : 0  }
    else
      return {"loc" : "up", "size" : hh, "width" : A_ScreenWidth, "height" : A_ScreenHeight - hh, "x" : 0, "y" : hh  }
  }
  get_stat_height(){
    create_gui("PANEL", "size_test", "NORMAL", -100, -100, "000000", "FFFFFF", "220")
    WinGetPos,xx,yy,ww, hh, size_test
    return hh
  }
}