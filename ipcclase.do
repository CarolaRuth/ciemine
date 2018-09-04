set more off
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Base de datos: Índice de Precios al Consumidor S/ CLASE
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

global in 	"https://raw.githubusercontent.com/CarolaRuth/ciemine/master"
global dta	"https://raw.githubusercontent.com/CarolaRuth/ciemine/master/_dta"

local deptos "SUCRE LAPAZ COCHABAMBA"
foreach d of local deptos{
forvalues i=2008(1)2017{
import excel using "$in/PreciosPromedio_`d'.xls", firstrow sheet(`i') clear
renvars, lower
rename descripcion descripcion`i'

replace umedida=	"1"	if umedida==	"UNIDAD(es)"
replace umedida=	"2"	if umedida==	"KILO(s)"
replace umedida=	"3"	if umedida==	"GRAMO(s)"
replace umedida=	"4"	if umedida==	"PAR(es)"
replace umedida=	"5"	if umedida==	"MES(es)"
replace umedida=	"6"	if umedida==	"MILILITRO(s)"
replace umedida=	"7"	if umedida==	"CUARTILLA"
replace umedida=	"8"	if umedida==	"SERVICIO"
replace umedida=	"9"	if umedida==	"LITRO(s)"
replace umedida=	"10"	if umedida==	"PASAJE"
replace umedida=	"11"	if umedida==	"CM3(s)"
replace umedida=	"12"	if umedida==	"CONJUNTO"
replace umedida=	"13"	if umedida==	"MINUTO(s)"
replace umedida=	"14"	if umedida==	"ARROBA"
replace umedida=	"15"	if umedida==	"HORA(s)"
replace umedida=	"16"	if umedida==	"JUEGO"
replace umedida=	"17"	if umedida==	"MONTÓN" | umedida==	"MONTON"
replace umedida=	"18"	if umedida==	"DÍA(s)"
replace umedida=	"19"	if umedida==	"ENTRADA"
replace umedida=	"20"	if umedida==	"METRO(s) CUBICO(s)"
replace umedida=	"21"	if umedida==	"AMARRO(s)"
replace umedida=	"22"	if umedida==	"KWH"
replace umedida=	"23"	if umedida==	"MANOJO"
replace umedida=	"24"	if umedida==	"METRO(s)"
replace umedida=	"25"	if umedida==	"ONZA(s)"
replace umedida=	"26"	if umedida==	"PIEZA(s)"
replace umedida=	"27"	if umedida==	"METRO(s) CUADRADO(s)"
replace umedida=	"28"	if umedida==	"LIBRA(s)"
replace umedida=	"29"	if umedida==	"K'API"
destring umedida, replace

#delimit ;
label define umedida
1	"UNIDAD(es)"
2	"KILO(s)"
3	"GRAMO(s)"
4	"PAR(es)"
5	"MES(es)"
6	"MILILITRO(s)"
7	"CUARTILLA"
8	"SERVICIO"
9	"LITRO(s)"
10	"PASAJE"
11	"CM3(s)"
12	"CONJUNTO"
13	"MINUTO(s)"
14	"ARROBA"
15	"HORA(s)"
16	"JUEGO"
17	"MONTÓN"
18	"DÍA(s)"
19	"ENTRADA"
20	"METRO(s) CUBICO(s)"
21	"AMARRO(s)"
22	"KWH"
23	"MANOJO"
24	"METRO(s)"
25	"ONZA(s)"
26	"PIEZA(s)" 
27  "METRO(s) CUADRADO(s)" 
28	"LIBRA(s)" 
29  "K'API" ;
#delimit cr
lab values umedida umedida

cap drop depto
gen str10 depto="`d'"

replace depto="1" if depto=="SUCRE"
replace depto="2" if depto=="LAPAZ"
replace depto="3" if depto=="COCHABAMBA"
replace depto="4" if depto=="ORURO"
replace depto="5" if depto=="POTOSI"
replace depto="6" if depto=="TARIJA"
replace depto="7" if depto=="SANTACRUZ"
replace depto="8" if depto=="TRINIDAD"
replace depto="9" if depto=="COBIJA"
destring depto, replace

#delimit ;
label define depto
1 	"Sucre"
2 	"La Paz"
3 	"Cochabamba"
4 	"Oruro"
5 	"Potosí"
6 	"Tarija"
7 	"Santa Cruz"
8 	"Trinidad"
9 	"Cobija" ;
#delimit cr
lab values depto depto

saveold "$dta/pp`d'`i'", replace version(12)
}
}

/*
use "$dta\ppLAPAZ2008.dta", clear
forvalues i=2009(1)2017{
merge 1:1 variedad umedida using "$dta\ppLAPAZ`i'", keepusing(descripcion`i') generate(m`i')
}
destring variedad, replace
format variedad %12.0g

*merge 1:n variedad umedida using "$dta\ppsucre2018", keepusing(descripcion2018) generate(m2018)
*/

local deptos "SUCRE LAPAZ COCHABAMBA"
foreach d of local deptos{
forvalues i=2008(1)2017{
use "$dta/pp`d'`i'.dta", clear

cap drop idclase
gen str12 idclase=variedad

cap drop iddivision
gen str20 iddivision=substr(idclase,1,2) 

destring idclase iddivision, replace
format idclase %12.0g

#delimit ;
label define division
1 	"Alimentos y bebidas no alcohólicas"
2 	"Bebidas alcohólicas y tabaco"
3 	"Prendas de vestir y calzado"
4 	"Vivienda, agua, electricidad, gas y otros combustibles"
5 	"Muebles y artículos domésticos para el hogar y gastos corrientes de conservación de la vivienda"
6 	"Salud"
7 	"Transporte"
8 	"Comunicaciones"
9 	"Recreación y cultura"
10 	"Educación"
11	"Restaurantes y hoteles"
12	"Bienes y servicios diversos" ;
#delimit cr
lab values iddivision division

#delimit ;
label define clase
111010101	"Pan corriente"
111010201	"Pan especial (1)"
111020101	"Galletas dulces "
111020201	"Galletas de agua"
111030101	"Arroz (grano largo)"
111030102	"Arroz (estaquilla)"
111040101	"Maíz"
111040401	"Harina de trigo"
111040501	"Harina de maíz"
111060101	"Fideo (corto)"
111060102	"Fideo (largo)"
112010101	"Carne de res con hueso (Pulpa con hueso)"
112010102	"Carne de res con hueso (Chuleta de res)"
112010201	"Carne de res sin hueso (Pulpa de res)"
112010301	"Carne molida de res "
112010401	"Hueso de res"
112020101	"Carne de cerdo"
112030101	"Carne de cordero"
112040101	"Carne de pollo (entero)"
112060101	"Hígado"
112060201	"Panza de res"
112070301	"Chorizos"
112070401	"Carnes frías"
113010101	"Sábalo (2)"
114010101	"Leche natural"
114010201	"Leche pasteurizada"
114010203	"Leche pasteurizada (ligth)"
114020101	"Leche en polvo"
114020102	"Leche en polvo (para lactantes)"
114030101	"Yogurt"
114040101	"Queso criollo"
114050101	"Huevo de gallina"
115010101	"Aceite comestible"
115010102	"Aceite (light) comestible"
115020201	"Margarina"
116010101	"Manzana"
116010201	"Naranja"
116010301	"Mandarina"
116010501	"Limón"
116010601	"Plátano/banano/guineo"
116010801	"Papaya"
116010901	"Uva"
116011001	"Sandía"
117010101	"Tomate (perita)"
117010102	"Tomate (redondo)"
117010201	"Lechuga (crespa)"
117010202	"Lechuga (repollada)"
117010301	"Cebolla (entera)"
117010302	"Cebolla (cortada)"
117010401	"Zanahoria"
117010501	"Arveja"
117010601	"Haba"
117010701	"Acelga"
117010801	"Choclo"
117010901	"Locoto"
117011001	"Pimentón/morrón"
117011301	"Vainita"
117020101	"Papa (imilla)"
117020102	"Papa (negra)"
117020103	"Papa (holandesa)"
117030101	"Chuño"
117030501	"Maní crudo"
118010101	"Azúcar granulada"
118020101	"Mermelada"
118030101	"Chocolate en tableta/bombones"
118030201	"Caramelos/dulces (Chupete)"
118040101	"Helado "
119010101	"Sal"
119010201	"Ají molido (amarillo)"
119010301	"Perejil"
119020101	"Mayonesa"
121010101	"Café molido"
121010201	"Café instantáneo"
121020201	"Coca en hoja"
121030101	"Cacao/cocoa en polvo"
1220201	"Bebidas gaseosas"
122040101	"Polvos para preparar refresco o jugo"
211010101	"Singani (de primera)"
213010101	"Cerveza (blanca)"
220010101	"Cigarrillo (rubio)"
311010101	"Tela para confeccionar prendas de vestir"
312010101	"Chamarra no de cuero  (Mujer)"
312010301	"Chompa  (Mujer)"
312010401	"Chompa (Niña)"
312010501	"Prendas de vestir de cuero  (Hombre)"
312020201	"Traje sastre  (Hombre)"
312020402	"Conjunto (Niña)"
312020501	"Pantalón / jeans  (Mujer) (3)"
312020503	"Pantalón / jeans  (Hombre)"
312020601	"Pantalón / jeans (Niña)"
312020603	"Pantalón / jeans (Niño)"
312020701	"Vestido (Mujer)"
312020801	"Falda (Mujer)"
312020901	"Pollera"
312021001	"Camisa manga larga (Hombre)"
312021201	"Blusa manga 3/4 (Mujer)"
312021301	"Polera (Hombre)"
312021402	"Polera (Niño)"
312021501	"Uniforme escolar (Niña/adolecente)"
312030101	"Conjunto de buzo deportivo  (Mujer)"
312030201	"Conjunto de buzo deportivo (Niña)"
312030301	"Buzo deportivo suelto  (Hombre)"
312030402	"Buzo deportivo suelto (Niño)"
312040101	"Conjunto de algodón para bebe"
312040201	"Pantalón para bebe"
312050101	"Brasier/sostén "
312050201	"Calzón  (Mujer)"
312050202	"Calzoncillo  (Hombre)"
312050301	"Calzoncillo (Niño)"
312050302	"Calzón (Niña)"
312050401	"Medias  (Mujer)"
312050402	"Medias  (Hombre)"
312050501	"Medias (Niño)"
312050502	"Medias (Niña)"
313010101	"Lana para tejer "
321010101	"Calzados  (Mujer)"
321010102	"Calzados  (Hombre)"
321010201	"Calzados (Niño)"
321010202	"Calzados (Niña)"
321010301	"Calzados para Bebe"
321020101	"Calzados deportivos  (Mujer)"
321020102	"Calzados deportivos  (Hombre)"
321020201	"Calzados deportivos (Niño)"
321020202	"Calzados deportivos (Niña)"
321030101	"Sandalia  (Hombre)"
322010101	"Servicio de reparación de calzados"
431010101	"Cemento"
432010101	"Servicio de albañilería"
441010101	"Servicio de suministro de agua potable"
444010101	"Servicio de seguridad (Privada)"
451010101	"Servicio de suministro de energía eléctrica"
452010101	"Servicio de suministro de gas natural por red"
452020101	"Gas licuado"
452020201	"Garrafa de gas vacía"
454010101	"Carbón"
511010101	"Cama"
511010201	"Ropero"
511010301	"Colchón (resorte)"
511020101	"Juego de living"
511030101	"Juego de comedor"
520010101	"Edredón"
520010201	"Juego de sábanas"
520010301	"Frazada"
520020101	"Toalla"
531010101	"Cocina a gas"
531020101	"Refrigerador"
532010101	"Licuadora"
532010201	"Plancha"
540010102	"Cacerola"
552010101	"Foco/bombilla eléctrica"
552010201	"Pila (mercurio)"
561010101	"Detergente en polvo"
561010201	"Detergente de lavar vajilla"
561010301	"Jabón"
561010401	"Lavandina"
561010501	"Ambientador"
561020101	"Escoba con mango"
561020201	"Esponja para lavar vajilla"
561030301	"Vela"
561030401	"Fósforo"
5620101	"Servicio de trabajadora del hogar"
562010201	"Servicio de lavado de ropa"
611010101	"Analgésico"
611010201	"Unguento/pomada"
611010301	"Medicamento para el estómago"
611010401	"Medicamento para el ojo"
611010501	"Tónico reconstituyente"
611010601	"Vitamina/multivitamina"
611010701	"Suero"
612010101	"Algodón"
621010101	"Consulta medica general"
621020101	"Consulta especializada (pediatría)"
621020201	"Consulta a oftalmólogo"
622010101	"Servicio dental (obturación simple)"
623010101	"Análisis de laboratorio clínico (hemograma completo)"
623020101	"Servicio de rayos X (torax)"
630010101	"Servicio de hospitalización"
711010101	"Automóvil"
712010101	"Motocicleta"
722010201	"Gasolina Especial"
722010202	"Gasolina Premium"
722010301	"Diesel"
723010201	"Servicio de cambio de aceite"
732010101	"Servicio de transporte en Trufi"
732010301	"Servicio de transporte en Microbús/Bus"
732020101	"Servicio de transporte en Taxi "
732020201	"Servicio de transporte en Radio taxi"
732030101	"Servicio de transporte interprovincial"
732030201	"Servicio de transporte interdepartamental"
733010101	"Servicio de transporte Aéreo"
820010101	"Aparato telefónico celular (4)"
830010101	"Servicio de telefonía domiciliaria  (Local)"
830010102	"Servicio de telefonía (Nacional)"
830010103	"Servicio de telefonía (Internacional)"
830020101	"Servicio de telefonía móvil (Post pago)"
830020102	"Servicio de telefonía móvil (Pre pago)"
830030101	"Servicio de Internet (Público)"
830030102	"Servicio de Internet (Domiciliario)"
830040101	"Servicio de telefonía pública (local)"
911010101	"Televisor"
911010201	"Video reproductor/DVD"
911020101	"Radiograbadora"
911020201	"Minicomponente"
912010101	"Cámara fotográfica"
912010201	"Filmadora"
913010101	"Computadora (5)"
914010101	"Disco compacto de música/video pregrabado"
931010301	"CD - DVD para videojuego"
931010401	"Juegos y juguetes (Muñeca)"
941010101	"Espectáculo deportivo (Fútbol Profesional)"
941020201	"Alquiler de cancha deportiva (Raquet)"
941020301	"Servicio de gimnasio (Máquinas)"
942010101	"Entrada a cine"
942030101	"Servicio de televisión por cable"
942040101	"Servicio de música (amplificación)"
951010101	"Libro de instrucción escolar y universitaria"
951010201	"Libro de novela y cuentos"
952010101	"Periódico"
954010101	"Material de escritorio (cuaderno)"
954010201	"Productos de papelería (papel bond)"
1010010101	"Pensión para educación preescolar/ kinder"
1010020101	"Pensión para educación primaria"
1020010101	"Pensión para educación secundaria"
1040010101	"Matricula educación superior universitaria"
1040010201	"Pensión para educación superior universitaria"
1040020101	"Pensión para educación superior post universitaria/maestria post grados"
1050010201	"Matricula educación en institutos"
11110101	"Desayuno"
1111010201	"Api"
11110103	"Almuerzo consumido fuera del hogar"
11110104	"Cena "
11110105	"Plato especial "
1111010601	"Pizzas "
11110201	"Hamburguesas"
1111020201	"Salteña"
1111020401	"Sándwich"
1111020801	"Pollo preparado (broaster)"
1111020802	"Pollos preparado (spiedo, brasa)"
1111030101	"Torta/pastel"
1111040101	"Gaseosa consumida fuera del hogar"
1111040301	"Fresco hervido no alcohólico consumido fuera del hogar"
1111040501	"Jugo de fruta consumida fuera del hogar"
1111050101	"Cerveza consumida fuera del hogar"
1111050201	"Chicha alcohólica consumida fuera del hogar"
1120010101	"Servicio de Hospedaje"
1211010102	"Servicio de corte (mujer)"
1211010201	"Servicio de teñido de cabellos"
1213010101	"Cepillo de dientes"
1213010201	"Máquina de afeitar (desechable)"
1213020101	"Jaboncillo"
1213020201	"Pasta dental"
1213020301	"Champú (cojín)"
1213020302	"Champú (frasco)"
1213020401	"Crema de enjuague capilar"
1213020501	"Desodorante (mujer)"
1213030101	"Perfume"
1213030202	"Cosméticos de belleza (delineador)"
1213030301	"Protector solar"
1213030601	"Crema de belleza para la piel"
1213040101	"Pañal desechable para bebé"
1213040201	"Papel higiénico"
1213040301	"Toalla sanitaria/higienica"
1231010101	"Reloj de pulsera (mujer)"
1232010101	"Mochila escolar"
1254010101	"Seguro de vehículo"
1270010101	"Servicio de fotocopiado"
1270020101	"Cédula de identidad/carnét de identidad"
1270020201	"Emisión de certificado de nacimiento" 
111010102	"Pan corriente (surtido)"
111020301	"Empanada"
111050101	"Avena"
111050201	"Copos de maíz "
112010202	"Carne de res sin hueso (cadera)"
112040201	"Presas de pollo"
112070501	"Salchichas"
113010201	"Pejerrey"
113010401	"Trucha"
113010501	"Karachi"
113020101	"Sardina en lata"
114020201	"Leche evaporada"
115020101	"Mantequilla"
116010701	"Plátano/postre para cocinar"
117011401	"Nabo"
117011501	"Zapallo"
117030201	"Tunta"
119030101	"Caldos en cubitos"
121020101	"Té en bolsita"
122010101	"Agua embotellada"
122030101	"Jugos de fruta"
312010202	"Chamarra no de cuero (niño)"
312010302	"Chompa  (Hombre)"
312010601	"Manta de chola "
312020101	"Saco   (Hombre)"
312030701	"Polera deportiva  (Hombre)"
314010101	"Servicio de confección de prendas de vestir a medida"
314020101	"Servicio de limpieza en seco"
322010201	"Servicio de lustrado de calzados"
444010201	"Gastos de administración de edificios"
511030201	"Modular"
520030101	"Cortina de ventana"
531030101	"Lavadora de ropa"
540010101	"Olla"
552010202	"Pila (alcalina)"
561010601	"Cera para pisos "
561030101	"Bolsa plástica /nylon"
561030201	"Guantes de goma"
613010101	"Anteojos de corrección (montura y lentes)"
630010201	"Servicio de parto"
721010101	"Llanta"
722010101	"Gas natural"
723010101	"Servicio de afinado de motor"
724010101	"Servicio de alquiler de garaje y estacionamiento"
732010201	"Servicio de transporte en Minibús"
732040101	"Servicio de transporte escolar (góndola)"
911020301	"Reproductor portátil de música"
922010101	"Instrumentos musicales (Sampoña)"
931010101	"Bicicleta"
941020101	"Servicio de piscina"
942020101	"Revelado de película"
942040201	"Alquiler de salón de fiestas"
960010101	"Paquete turístico"
1050010101	"Pensión para otras carreras cortas en institutos"
1050010301	"Pensión en institutos de idiomas extranjeros"
1050010401	"Pensión en institutos de informática"
1111020301	"Tucumana/empanada frita"
1111020501	"Salchipapa"
1211010101	"Servicio de corte (mujer)"
1211020201	"Servicio de ducha pública"
1213030102	"Colonia"
1213030201	"Cosméticos de belleza (lápiz labial)"
1213040401	"Pañuelo desechable"
1240010101	"Servicio de guardería" 
0114010202	"Leche pasteurizada (saborizada)"
0114010301	"Leche de soja"
0114040102	"Queso criollo (quesillo)"
0114040201	"Queso industrializado (muzarella)"
0116011101	"Durazno"
0116011201	"Palta"
0117011201	"Pepino "
0117020201	"Yuca/mandioca"
0118030301	"Goma de mascar/chicle"
0312030501	"Pantalón corto  (Hombre)"
0312040301	"Polera para bebe"
0313020101	"Gorro visera"
0511010302	"Colchón (espuma)"
0531010301	"Horno microondas"
0540020101	"Vaso"
0540030101	"Balde"
0540030102	"Bañador"
0552010102	"Tubo fluorescente"
0561040101	"Servilletas de papel"
0723010301	"Servicio de lavado de vehículo"
1111020701	"Huminta/ tamal"
1211020101	"Servicio de sauna"
1213030501	"Fijador de cabello (gel)"
1231010102	"Reloj de pulsera (hombre)"
1232010201	"Cartera (mujer)" ;
#delimit cr
lab values idclase clase

cap drop año
gen año=`i'
 
save "$dta/pp`d'`i'.dta", replace
}
}

clear
***********
local deptos "SUCRE LAPAZ COCHABAMBA"
foreach d of local deptos{
forvalues j=2008(1)2017{
use "$dta/pp`d'`j'.dta", clear

local i=1
foreach var of varlist enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre{
rename `var' a`var'
rename a`var' a`i'
local i=`i'+1
}

reshape long a, i(idclase) j(mes)

save "$dta/spp`d'`j'.dta", replace
}

use "$dta/spp`d'2008.dta", clear
forvalues i=2009(1)2017{
append using "$dta/spp`d'`i'.dta"
}

cap drop capitulo
drop descripcion* 
rename a precio
order año mes idclase iddivision depto precio cantidad umedida 

cap drop t
gen t=ym(año,mes)
format t %tm

tsset idclase t

label var año 			"Año"
label var mes 			"Mes"
label var idclase 		"Identificador único de producto"
label var iddivision	"Identificador único de división (agrupación de producto)"
label var depto			"Ciudad"
label var precio		"Precio promedio"
label var cantidad		"Cantidad de unidad referencial del precio"
label var variedad		"Id bruto"
label var t 			"Variable año/mes"
order t idclase iddivision depto precio cantidad umedida año mes

save  "$dta/spp`d'.dta", replace
}

use "$dta/sppSUCRE.dta", clear
local deptos "LAPAZ COCHABAMBA"
foreach d of local deptos{
append using "$dta\spp`d'.dta"
}
*save "$dta/sppBOLIVIA.dta", replace

local deptos "SUCRE LAPAZ COCHABAMBA"
foreach d of local deptos{
forvalues i=2008(1)2017{
erase "$dta/spp`d'`i'.dta"
erase "$dta/pp`d'`i'.dta"
}
}
