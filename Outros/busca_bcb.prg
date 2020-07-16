
'O programa utiliza a interface Eviews-R para, a partir do pacote BETS* (Brazilian Economics Time Series) coletar/buscar s�ries temporais do BCB (principalmente) al�m de outros org�os como FGV-IBRE ou IBGE.

'O primeiro ponto que temos que levar en considera��o � a vers�o do R instalada. Essa interface s� funciona para uma vers�o do R superior a 3.3 (no momento em que esse programa � inscrito a vers�o do R � a 3.5.1, 02/07/2018). O pacote utilizado (BETS) est� na vers�o 0.4.4.   

'checa a vers�o do R:

xopen(type=r) 'abre a interface/linha de comando do R

if @xvernum<3.3 then ' se a vers�o do R for < 3.3, o programa para.
	%error = "Atualize a sua vers�o do R"
	@uiprompt(%error)
	stop
endif 

'O BETS (de forma majorit�ria) utiliza os n�meros das s�ries temporais do BCB para coletar as s�ries, por exemplo: IPCA % mensal (numero 433); ou Atividade Economica do BC (IBC-Br) (24363)

'Al�m disso, na d�vida, � poss�vel uma consulta a todas as s�ries dispon�veis pela fun��o "BETSserach()". A fun��o possui alguns argumentos, os principais s�o "description" (A string desejada para a busca); "lang" (o idioma default � o ingles (en), a op��o portugu�s (pt) tamb�m est� dispon�vel); "src" ('the source of the series' - IBGE e FGV s�o alguns dos par�metros poss�veis)*; "periodicity" (A frequ�ncia da s�rie: A - dados anuais, M - dados mensais, Q - dados trimestrais....)

'Par�metros para src:
'IBGE	 Brazilian Institute of Geography and Statistics
'BCB	 Central Bank of Brazil
'FGV	 Getulio Vargas Foundation
'FGv-IBRE	 Getulio Vargas Foundation - Brazilian Institute of Economics
'BCB e FGV	 Central Bank of Brazil and Getulio Vargas Foundation
'BCB-Deban	 Cetral Bank of Brazil - Department of Banking and Payments
'BCB-Depin	 Central Bank of Brazil - Department of International Reserves
'BCB-Derin	 Central Bank of Brazil - Department of International Affairs
'BCB-Desig	 Central Bank of Brazil - Department of Financial Monitoring
'BCB-Secre	 Central Bank of Brazil - Executive Secretariat
'BCB-Demab	 Central Bank of Brazil - Department of Open Market Operations
'BCB-Denor	 Central Bank of Brazil - Department of Financial System Regulation
'BCB-Depec	 Central Bank of Brazil - Department of Economics
'Sisbacen	 Central Bank of Brazil Information System
'Abecip	 Brazilian Association of Real Estate Loans and Savings Companies

'EXEMPLO:

'not run
'xopen(type=r)
'xpackage BETS
'xrun View(BETSsearch(description = 'ipca', src = 'IBGE', lang = 'pt')
'xclose(type=r)

'OBS o xrun e xpackage caracteriza que o codigo foi escrito pela linha de comando do Eviews. 

'==================================================================
'					Exemplo de coleta de algumas s�ries, pela interface
'==================================================================

'O SAMPLE DO WORFILE  FOI 1990m01 2018m07

xpackage BETS 'carrega o pacote BETS. Se esse n�o estiver instalado ele � instalado automaticamente. No mais, bastaria um 'install.packages("BETS") para instalar pela linha de comando do R. Na linha de comando do R usamos o library(BETS).

'O xrun � o comando dado para rodar um comando a partir do R..

'IPCA %mensal (433)

xrun ipca<- BETSget(433, from ="1994-07-01", to = "2018-07-01") 'Pega a s�rie IPCA % m, do per�odo de julho de 1994 � julho de 2018. Basicamente a fun��o possui a seguinte estrutura: BETSget(code, from = "", to = "").

smpl @all

'IBC-Br (24363) ' a serie come�a em 01/01/2003 e o �ltimo valor at� agora � em junho/2018

xrun pib<- BETSget(24363, from ="2003-01-01", to = "2018-06-01")

smpl @all

'Taxa de cambio - Livre - Dolar americano (Venda) - media do periodo (mensal) (3698)

xrun cambio<- BETSget(3698, from ="1990-01-01", to = "2018-06-01")

smpl 1994m07 @last
xget(name = ipca, type = series) ipca 'exporta para o Wf a serie ipca com o nome ipca

smpl 2003m01 @last
xget(name = pib_bc, type = series) pib 'exporta para o Wf a s�rie pib com o nome pib_bc

smpl @all
xget(name = cambio, type = series) cambio 'exporta para o Wf a s�rie cambio com o nome cambio

'OBS: A DATA INICIAL DO 'FROM' TEM QUE SER IGUAL A DO SAMPLE!!!!!	

'O parametro name � referente ao nome dado na interface para a serie, o type � referente ao tipo da veariavel que o Eviews receber� (� possivel, por exemplo exportar uma estima��o feita no R para o Eviews....)

xclose 'fecha a interface com o R

'Para mais informa��es sobre o pacote BETS: 

'https://cran.r-project.org/web/packages/BETS/BETS.pdf

