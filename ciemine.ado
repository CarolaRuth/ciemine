**PROYECTO DE SISTEMATIZACIÓN DE BASE DE DATOS
**Autora: CAROLA TITO VELARDE
**Versión 0
capture program drop ciemine
program define ciemine
version 8.0
	syntax anything
	quietly {
	clear *
	do "https://raw.githubusercontent.com/CarolaRuth/ciemine/master/`anything'.do"
	}
end

