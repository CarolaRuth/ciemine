{smcl}
{* *! version 0.0.0 29ago2018}{...}

{title:Title}

{phang}
{bf:ciemine} {hline 2} Presenta bases oficiales del Instituto Nacional de Estadística de 
Bolivia armonizadas y sistematizadas para uso del CIEMCorp.

		{phang}{cmd:Las bases disponibles son:}{p_end}
		
		{pmore}
		{hline 1} [serieipc] Índice de Precios al Consumidor (IPC) serie histórica mensual de 1937 al 2018. 
		
		{pmore}
		{hline 1} [ipcclase_{ciudad}] Precio promedio por clase (tipo de producto de la canasta familiar) mensual de 2008 al 2017. 
		
{title:Syntax}

{p 10 17 2}
{cmdab: ciemine}
[{base}]

{title:Description}
{pstd}
{cmd:ciemine} permite el acceso a bases sistematizadas y armonizadas disponibles en el Instituto Nacional de Bolivia. 
{base} es el identificador de la base que se desea explorar.

{title:Remarks}
{pstd}
Para más información de los indicadores de la base de serieipc, ver {browse "http://www.youtube.com/watch?v=GhVGpe3lb3E":Ficha Técnica IPC}.

{title:Examples}

{phang}
{it: Figura 1} Gráfico de la variación mensual del IPC 1938(Diciembre)-2018(Julio) en porcentaje. 

  {cmd:. tsline varipc, graphregion(color(white)) ylabel(0(20)200, format(%10.0g)} 
	{cmd: angle(h) labsize(small) glcolor(gs15)) tlabel(1937m1(84)2014m1 2018m12,}
	{cmd: labsize(vsmall) grid gmax alternate glcolor(gs15)) xtitle("")}
	{cmd: tmtick(1938m1(12)2018m6, grid glcolor(gs15))}
	{cmd: ytitle("Variación Mensual del IPC % (Base=2016)",}
	{cmd: size(small) color(dknavy))}
  {it:({stata gr_ipc tslineipc:click to run})}
{* graph tslineipc}{...}

{phang}
{it: Figura 2} Gráfico de la variación anual del IPC 1938(Diciembre)-2018(Julio) en porcentaje. 

  {cmd:. tsline varipc_ac if mes==12 & año>=1990, graphregion(color(white)) ylabel(-1(1)19,} 
	{cmd: angle(h) labsize(small) glcolor(gs15)) tlabel(1990m12(24)2018m12,}
	{cmd: format(%10.0g) labsize(vsmall) grid gmax alternate glcolor(gs15)) xtitle("")}
	{cmd: tmtick(1990m12(12)2018m12, grid glcolor(gs15))}
	{cmd: ytitle("Variación Anual del IPC % (Base=2016)",}
	{cmd: size(small) color(dknavy))}
  {it:({stata gr_ipc tslineipc_ac:click to run})}
{* graph tslineipc_ac}{...}

{title:Author}

{pstd}
Carola Ruth Tito Velarde. CIEMCorp.
{p_end}


     
