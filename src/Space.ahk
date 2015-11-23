/*
	@Author : johngrib82@gmail.com
	@Created : 2015. NOV. 19
*/
#if GetKeyState("capslock","T")
    /*
        space + qweasdzxc
        moves mouse pointer to edge of activated window
        
        q : left top
        w : center top
        e : right top
        ...
        z : left bottom
        x : center bottom
        c : right bottom
    */
	$Space::return
	Space & q::
		MouseMove, 2, 0
	return
	
	Space & w::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww/2, 0
	return

	Space & e::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww - 2, 0
	return

	Space & a::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, 2, hh/2	
	return

	Space & s::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww/2, hh/2	
	return
	
	Space & d::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww - 2, hh/2	
	return

	Space & z::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, 2, hh - 2	
	return

	Space & x::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww/2, hh - 2
	return
	
	Space & c::
		WinGet, winid ,, A
		WinGetActiveStats, winid, ww, hh, xx, yy
		MouseMove, ww -2, hh - 2 
	return
	
#if