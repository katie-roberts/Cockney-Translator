var qs = new Querystring();

function popup(url, w, h) {
	var features = '';
	
	var winl;
	var wint;
	
	if(screen.width){
		winl = (screen.width-w)/2;
		wint = (screen.height-h)/2;
	} else {
		winl = 0;
		wint = 0;
	}
	
	if (winl < 0) winl = 0;
	if (wint < 0) wint = 0;
	
	var settings = 'height=' + h + ',';
	settings += 'width=' + w + ',';
	settings += 'top=' + wint + ',';
	settings += 'left=' + winl + ',';
	settings += 'scrollbars=1';
	settings += 'resizable=1';
	settings += features;
	
	win = window.open(url,'popupWindow', settings);
	if (win) win.window.focus();
	
}