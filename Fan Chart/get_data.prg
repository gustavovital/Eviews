'checa a versão do R:

xopen(type=r) 'abre a interface/linha de comando do R

if @xvernum<3.3 then ' se a versão do R for < 3.3, o programa para.
	%error = "Atualize a sua versão do R"
	@uiprompt(%error)
	stop
endif 

' carrega o pacote BETS

xpackage BETS
xpackage ggplot2

' Carrega as series

smpl 2002:01 2019:12

xrun cambio<- BETSget(3698, from ="2002-01-01", to = "2019-12-01")
xrun ibcbr <- BETSget(24363, from ="2002-01-01", to = "2019-12-01")
xrun ipca <- BETSget(433, from ="2002-01-01", to = "2019-12-01")

xget(name = cambio, type = series) cambio
xget(name = ibcbr , type = series) ibcbr 
xget(name = ipca, type = series) ipca

genr d_cambio = d(cambio)
genr d_ibcbr = d(ibcbr)

xclose 'fecha a interface com o R


