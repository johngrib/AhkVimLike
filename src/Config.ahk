class Config {
		__New(file_address) {
			this.file_address := file_address
			
			this.cfg := {}
			this.cfg["NORMAL"] := {"font_color" : "FF0000", "bg_color" : "000000" }
			this.cfg["INSERT"] := {"font_color" : "3F51B5", "bg_color" : "FFFFFF" }		
			this.cfg["CAPSLOCK"] := {"font_color" : "FF4081", "bg_color" : "FFFFFF" }
	
			for sect, obj in this.cfg {
				for key, def in obj {
					ini_value := this.get_ini_value(sect, key, def)
					if(this.is_invalid_value(key, ini_value)){
						ini_value := this.fix_ini_value( sect, key, this.cfg[sect][key] )
					}				
					this.cfg[sect][key] := ini_value
				}
			}
		} ; // end of __New
		
		get_value(sect, key){
			return this.cfg[sect][key]
		}
		
		get_ini_value(sect, key, default_value){
			file := this.file_address
			IniRead, value, %file%, %sect%, %key%, %default_value%
			return value
		}
		
		is_invalid_value( key, value ) {
			if( RegExMatch( key, "_color$" ) ){
				 return not RegExMatch( value, "^[0-9a-fA-F]{6}$" )
			}
		}
	
		fix_ini_value( sect, key, value ){
			file := this.file_address
			IniWrite, %value%, %file%, %sect%, %key%
			return value
		}
}