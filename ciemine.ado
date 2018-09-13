*! version 1 13sept2018
capture program drop ciemine 
program define ciemine
version 7.0
	syntax anything
	quietly {
	clear *
	do "https://raw.githubusercontent.com/CarolaRuth/ciemine/master/`anything'.do"
	}
end
