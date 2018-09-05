*! version 1 
version 13
program define ciemine
	syntax anything
	quietly {
	clear *
	do "https://raw.githubusercontent.com/CarolaRuth/ciemine/master/`anything'.do"
	}
end

