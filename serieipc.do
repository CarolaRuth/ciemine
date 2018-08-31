clear all
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Base de datos: Índice de Precios al Consumidor HISTÓRICO
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

global in "D:\documentos\cies\Proyectos\Datos\BIcase\bd\xlsx"
import excel using "$in\serieipc.xls", firstrow sheet(data)

reshape long a, i(MES) j(t)
format a %12.8fc

rename t 	año
rename MES 	mes

replace mes="1" 	if mes=="ENERO"
replace mes="2" 	if mes=="FEBRERO"
replace mes="3" 	if mes=="MARZO"
replace mes="4" 	if mes=="ABRIL"
replace mes="5" 	if mes=="MAYO"
replace mes="6" 	if mes=="JUNIO"
replace mes="7" 	if mes=="JULIO"
replace mes="8" 	if mes=="AGOSTO"
replace mes="9" 	if mes=="SEPTIEMBRE"
replace mes="10" 	if mes=="OCTUBRE"
replace mes="11" 	if mes=="NOVIEMBRE"
replace mes="12" 	if mes=="DICIEMBRE"
replace mes="100"	if mes=="PROM. ANUAL"

destring mes, replace

#delimit ;
label define mes
1 	"Enero"
2 	"Febrero"
3 	"Marzo"
4 	"Abril"
5 	"Mayo"
6 	"Junio"
7 	"Julio"
8 	"Agosto"
9 	"Septiembre"
10 	"Octubre"
11	"Noviembre"
12	"Diciembre" 
100 "Prom. Anual" ;
#delimit cr
lab values mes mes

cap drop t
gen t=ym(año,mes)
format t %tm

tsset t
drop if t==.

* * * * * * * * * * ** * * * * *
***VARIACION PORCENTUAL MENSUAL
* * * * * * * * * * ** * * * * *
rename a ipc
cap drop varipc
gen varipc=(D.ipc/L.ipc)*100
format varipc %12.2fc

/***GRÁFICO DE TRAYECTORIA MENSUAL
tsline varipc, graphregion(color(white)) ylabel(0(20)200, format(%10.0g) angle(h) labsize(small) glcolor(gs15)) ///
tlabel(1937m1(84)2014m1 2018m12, labsize(vsmall) grid gmax alternate glcolor(gs15)) ///
xtitle("") tmtick(1938m1(12)2018m6, grid glcolor(gs15)) ytitle("Variación Mensual del IPC % (Base=2016)", size(small) color(dknavy))

tsline ipc, scheme(burd10)
*/

* * * * * * * * * * ** * * * * * *
***VARIACION PORCENTUAL DOCE MESES
* * * * * * * * * * ** * * * * * *
cap drop varipc12
gen varipc12=(S12.ipc/L12.ipc)*100
format varipc12 %12.2fc

/***GRÁFICO DE TRAYECTORIA DOCE MESES
tsline varipc12, scheme(burd10)
tsline varipc12 if año>2000 & año<., scheme(burd10)

tsline varipc_ac if mes==12 & año>=1990, graphregion(color(white)) ylabel(-1(1)19, format(%10.0g) angle(h) labsize(small) glcolor(gs15)) ///
tlabel(1990m12(24)2018m12, labsize(vsmall) grid gmax alternate glcolor(gs15)) ///
xtitle("") tmtick(1990m12(12)2018m12, grid glcolor(gs15)) ytitle("Variación Anual del IPC % (Base=2016)", size(small) color(dknavy))

*/


* * * * * * * * * * ** * * * * * *
***VARIACION PORCENTUAL ACUMULADA
* * * * * * * * * * ** * * * * * *
cap drop varipc_ac
gen varipc_ac=.

levelsof mes, local(month)
foreach i of local month{
replace varipc_ac=((ipc-L`i'.ipc)/L`i'.ipc)*100 if mes==`i'
}
format varipc_ac %12.2fc

/***GRÁFICO DE TRAYECTORIA ACUMULADA
tsline varipc_ac, scheme(burd10)
*/
