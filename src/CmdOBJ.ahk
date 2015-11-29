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
			changeMode("auto")
		} else if(str = "num") {
			this.num := ""
		} else if(str = "cmd") {
			this.cmd := ""
		}
	}
}