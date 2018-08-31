**PROYECTO DE SISTEMATIZACIÓN DE BASE DE DATOS
**Autora: CAROLA TITO VELARDE
**Versión 0
capture program drop ciemine
program define ciemine
version 7.0
	syntax anything
	quietly {
	clear *
	do https://github.com/CarolaRuth/ciemine/`anything'.do
	}
end
exit
