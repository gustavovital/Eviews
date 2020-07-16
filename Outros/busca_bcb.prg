
'O programa utiliza a interface Eviews-R para, a partir do pacote BETS* (Brazilian Economics Time Series) coletar/buscar séries temporais do BCB (principalmente) além de outros orgãos como FGV-IBRE ou IBGE.

'O primeiro ponto que temos que levar en consideração é a versão do R instalada. Essa interface só funciona para uma versão do R superior a 3.3 (no momento em que esse programa é inscrito a versão do R é a 3.5.1, 02/07/2018). O pacote utilizado (BETS) está na versão 0.4.4.   

'checa a versão do R:

xopen(type=r) 'abre a interface/linha de comando do R

if @xvernum<3.3 then ' se a versão do R for < 3.3, o programa para.
	%error = "Atualize a sua versão do R"
	@uiprompt(%error)
	stop
endif 

'O BETS (de forma majoritária) utiliza os números das séries temporais do BCB para coletar as séries, por exemplo: IPCA % mensal (numero 433); ou Atividade Economica do BC (IBC-Br) (24363)

'Além disso, na dúvida, é possível uma consulta a todas as séries disponíveis pela função "BETSserach()". A função possui alguns argumentos, os principais são "description" (A string desejada para a busca); "lang" (o idioma default é o ingles (en), a opção português (pt) também está disponível); "src" ('the source of the series' - IBGE e FGV são alguns dos parâmetros possíveis)*; "periodicity" (A frequência da série: A - dados anuais, M - dados mensais, Q - dados trimestrais....)

'Parâmetros para src:
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
'					Exemplo de coleta de algumas séries, pela interface
'==================================================================

'O SAMPLE DO WORFILE  FOI 1990m01 2018m07

xpackage BETS 'carrega o pacote BETS. Se esse não estiver instalado ele é instalado automaticamente. No mais, bastaria um 'install.packages("BETS") para instalar pela linha de comando do R. Na linha de comando do R usamos o library(BETS).

'O xrun é o comando dado para rodar um comando a partir do R..

'IPCA %mensal (433)

xrun ipca<- BETSget(433, from ="1994-07-01", to = "2018-07-01") 'Pega a série IPCA % m, do período de julho de 1994 à julho de 2018. Basicamente a função possui a seguinte estrutura: BETSget(code, from = "", to = "").

smpl @all

'IBC-Br (24363) ' a serie começa em 01/01/2003 e o último valor até agora é em junho/2018

xrun pib<- BETSget(24363, from ="2003-01-01", to = "2018-06-01")

smpl @all

'Taxa de cambio - Livre - Dolar americano (Venda) - media do periodo (mensal) (3698)

xrun cambio<- BETSget(3698, from ="1990-01-01", to = "2018-06-01")

smpl 1994m07 @last
xget(name = ipca, type = series) ipca 'exporta para o Wf a serie ipca com o nome ipca

smpl 2003m01 @last
xget(name = pib_bc, type = series) pib 'exporta para o Wf a série pib com o nome pib_bc

smpl @all
xget(name = cambio, type = series) cambio 'exporta para o Wf a série cambio com o nome cambio

'OBS: A DATA INICIAL DO 'FROM' TEM QUE SER IGUAL A DO SAMPLE!!!!!	

'O parametro name é referente ao nome dado na interface para a serie, o type é referente ao tipo da veariavel que o Eviews receberá (é possivel, por exemplo exportar uma estimação feita no R para o Eviews....)

xclose 'fecha a interface com o R

'Para mais informações sobre o pacote BETS: 

'https://cran.r-project.org/web/packages/BETS/BETS.pdf

