**PROYECTO DE SISTEMATIZACIÓN DE BASE DE DATOS
**Autora: CAROLA TITO VELARDE
**Versión 0
capture program drop ciemine
program define ciemine
version 7.0
	syntax anything
	quietly {
	clear *
	do D:/documentos/cies/Proyectos/Datos/BIcase/data/_do/`anything'.do
	}
end
exit
