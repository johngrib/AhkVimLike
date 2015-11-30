class Config {
		__New(file_address) {
			this.file_address := file_address
			
			this.cfg := {}
			this.cfg["NORMAL"]   := {"font_color" : "FF0000", "bg_color" : "000000", "_title": "avl_normal"  }
			this.cfg["INSERT"]   := {"font_color" : "3F51B5", "bg_color" : "FFFFFF", "_title": "avl_insert"  }
			this.cfg["CAPSLOCK"] := {"font_color" : "FF4081", "bg_color" : "FFFFFF", "_title": "avl_capslock"}

			for sect, obj in this.cfg {
				for key, def in obj {
					ini_value := this.get_ini_value(sect, key, def)
					if(this.is_invalid_value(key, ini_value)){
						ini_value := this.fix_ini_value( sect, key, this.cfg[sect][key] )
					}				
					this.cfg[sect][key] := ini_value
				}
			}

			this.cfg["STAT_LOC"] := this.func_get_stat_location()
			
		} ; // end of __New
		
		has_sect(str){
			return this.cfg.HasKey(str)
		}
		
		get_sect(str){
			return this.cfg[str]
		}

		get_value(sect, key){
			return this.cfg[sect][key]
		}
		
		get_ini_value(sect, key, default_value){
			file := this.file_address
			IniRead, value, %file%, %sect%, %key%, %default_value%
			return value
		}
		
		is_invalid_value( key, value ) {
			if(RegExMatch( key , "^_"))
				return false
			
			if( RegExMatch( key, "^[^_]+_color$" ) )
				 return not RegExMatch( value, "^[0-9a-fA-F]{6}$" )
		}
	
		fix_ini_value( sect, key, value ){
			file := this.file_address
			IniWrite, %value%, %file%, %sect%, %key%
			return value
		}
		func_get_stat_location(){
			tray_info := this.func_get_tray_location()
			loc := tray_info["loc"]
			size := tray_info["size"]

			height := this.get_stat_height()
			if( loc = "down" )
				return {"x" : Floor(A_ScreenWidth/2), "y" : A_ScreenHeight - size - height }
			else
				return {"x" : A_ScreenWidth/2, "y" : A_ScreenHeight - height }
		}
		func_get_tray_location(){
			WinGetPos,xx,yy,ww,hh,ahk_class Shell_TrayWnd,,,
			if( ww > hh and yy > 0 )
				return {"loc" : "down", "size" : hh}
			else if( ww < hh and yy = 0 )
				return {"loc" : "left", "size" : hh}
			else if( ww < hh and xx > 0 )
				return {"loc" : "right", "size" : hh}
			else
				return {"loc" : "up", "size" : hh}
		}
		get_stat_height(){
			create_gui("PANEL", "size_test", "NORMAL", -100, -100, "000000", "FFFFFF")
			WinGetPos,xx,yy,ww, hh, size_test
			return hh
		}
}