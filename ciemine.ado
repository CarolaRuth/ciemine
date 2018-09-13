*! version 1 
program define ciemine
	syntax anything
	quietly {
	clear *
	do "https://raw.githubusercontent.com/CarolaRuth/ciemine/master/`anything'.do"
	}
end
