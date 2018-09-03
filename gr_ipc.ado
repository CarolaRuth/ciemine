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

cap program drop pp_al_cbba
program define pp_al_cbba
** DESVIACION AL PRECIO PROMEDIO
preserve
cap drop vacp
egen vacp=sd(precio) if mes==12, by(idclase)

cap drop sens
gen sens=.

local num "6 7 11"
foreach j of local num{
levelsof idclase if mes==12 & iddivision==`j' & vacp>1, local(clase)
foreach i of local clase{
replace sens=1 if idclase==`i' & iddivision==`j'
}
}

levelsof idclase if mes==12 & iddivision==3 & vacp>18, local(clase)
foreach i of local clase{
replace sens=1 if idclase==`i' & iddivision==3
}
levelsof idclase if mes==12 & iddivision==5 & vacp>4, local(clase)
foreach i of local clase{
replace sens=1 if idclase==`i' & iddivision==5
}
levelsof idclase if mes==12 & iddivision==12 & vacp>5, local(clase)
foreach i of local clase{
replace sens=1 if idclase==`i' & iddivision==12
}
levelsof idclase if mes==12 & iddivision==1 & vacp>4, local(clase)
foreach i of local clase{
replace sens=1 if idclase==`i' & iddivision==1
}
levelsof idclase if mes==12 & iddivision==9 & vacp>6, local(clase)
foreach i of local clase{
replace sens=1 if idclase==`i' & iddivision==9
}
replace sens=. if idclase==711010101 | idclase==712010101

/*
graph hbar precio if iddivision==4 & mes==12, over(año, label(labsize(tiny) ticks alternate)) ///
over(idclase, label(labsize(vsmall)) relabel(1 "Cemento	50 Kilos" 3 "Servicio de suministro de agua potable 16m3" ///
4 "Servicio de seguridad (Privada) Mes" 5 "Gastos de administración de edificios Mes" 6 "Servicio de suministro de energía eléctrica 80KWH" ///
7 "Servicio de suministro de gas natural por red 25m3" 8 "Gas licuado 10 Kilos" 9 "Carbón Unidad")) ///
graphregion(color(white)) ylabel(0(25)475, labsize(vsmall)) ymtick(0(12.5)475,grid) ytitle("")

graph hbar precio if iddivision==2 & mes==12, over(año, label(labsize(tiny) ticks alternate)) ///
over(idclase, label(labsize(vsmall)) relabel(1 "Cerveza (blanca) 620 cm3" 2 "Cigarrillo Rubio 20 unidades")) ///
graphregion(color(white)) ylabel(0(2)14, labsize(vsmall)) ymtick(0(1)14,grid) ytitle("")
*/
graph hbar precio if iddivision==1 & mes==12 & sens==1, over(año, label(labsize(tiny) ticks alternate)) ///
over(idclase, label(labsize(vsmall)) relabel(1 "Harina de maíz 1 cuartilla" 2 "Sábalo 1 unidad" ///
3 "Leche en polvo 1800 gramos" 4 "Leche en polvo (para lactantes) 400 gramos" 5 "Papa (imilla) 1 arroba" 6 "Papa (holandesa) 1 arroba")) ///
graphregion(color(white)) ylabel(0(10)120, labsize(vsmall)) ymtick(0(5)120,grid) ytitle("") ///
title("Cochabamba: Precio Promedio de Productos Alimenticios" "Seleccionados (en Bs)", size(small)) ///
note("Nota: Se han seleccionado los productos con una desviación estándar del precio" "mayor a 4 unidades monetarias según el año y el producto.", size(vsmall))
restore
end
