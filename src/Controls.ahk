/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/

func_x(ByRef input_number){
	if(GetKeyState("Shift"))
		Send, {BackSpace %input_number%}
	else if(input_number <> "")
		Send, {Delete %input_number%}
}