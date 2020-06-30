' Programa gen�rico para cria��o de um fanchart

' periodo de estima��o
%estimation_smpl = "@first 2018m12"

' periodo para a previsao
%forecast_period = "2019m01 2019m12"

'bootstrap? yes = 1, no = 0
!boot = 1

'incerteza de coeficientes? y = 1, n = 0
!coef_unc = 1

' numero de bandas no grafico
!numb = 3

' criando a variavel modelo e a variavel a ser prevista
%mod_name = "mod"
%varname = "ipca"

' definindo a estima��o
smpl {%estimation_smpl}

var var_ipca.ls 1 2 ipca d_ibcbr d_cambio
var_ipca.makemodel({%mod_name})

' ============= FAN CHART ==============
%quant_array = "90"

