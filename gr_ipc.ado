*! verison 0.0.1  30ago2018
program gr_ipc
	set more off
	`0'
end

cap program drop tslineipc
program define tslineipc
	tsline varipc, graphregion(color(white)) ylabel(0(20)200, format(%10.0g) angle(h) labsize(small) glcolor(gs15)) ///
	tlabel(1937m1(84)2014m1 2018m12, labsize(vsmall) grid gmax alternate glcolor(gs15)) ///
	xtitle("") tmtick(1938m1(12)2018m6, grid glcolor(gs15)) ytitle("Variación Mensual del IPC % (Base=2016)", size(small) color(dknavy))
end

cap program drop tslineipc_ac
program define tslineipc_ac
	tsline varipc_ac if mes==12 & año>=1990, graphregion(color(white)) ylabel(-1(1)19, format(%10.0g) angle(h) labsize(small) glcolor(gs15)) ///
	tlabel(1990m12(24)2018m12, labsize(vsmall) grid gmax alternate glcolor(gs15)) ///
	xtitle("") tmtick(1990m12(12)2018m12, grid glcolor(gs15)) ytitle("Variación Anual del IPC % (Base=2016)", size(small) color(dknavy))
end
