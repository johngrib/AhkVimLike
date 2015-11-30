/*
	command object
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 29
*/
class CmdOBJ {
		__New(cmd, num) {
			this.cmd := cmd
			this.num := num
		}
		set_cmd(cmd){
			this.cmd := cmd
		}
		set_num(num){
			this.num := num
		}
		get_num(){
			return this.num
		}
		get_cmd(){
			return this.cmd
		}
		get_num_cmd(){
			return this.num . this.cmd
		}
		append_num(num){
			this.num := this.num . num
		}
		append_cmd(cmd){
			this.cmd := this.cmd . cmd
		}
		clear(str){
			if(str = "auto"){
				this.cmd := ""
				this.num := ""
				this.changeMode("auto")
			} else if(str = "num") {
				this.num := ""
			} else if(str = "cmd") {
				this.cmd := ""
			}
		}

	;// capslock mode changer
		changeMode(opt){
			KeyWait, CapsLock
			GetKeyState, lockState, CapsLock, T)
			If(lockState = "D" && opt == "auto")	{
				option = on
				show_mode("NORMAL")
			} else If(lockState = "D" && opt == "caps")	{
				option = off
				show_mode("CAPSLOCK")
			} else {
				option = off
				show_mode("INSERT")
			}
			; enable / disable command hot keys
			command_keymap := func_get_key_maps()
			cnt := command_keymap.Length()
			Loop %cnt% {
				target_key := command_keymap[A_Index]
				Hotkey, %target_key%, %option%
			}
			return
		}
}