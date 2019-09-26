#include "totvs.ch"
#include "protheus.ch"
#include "topconn.ch"

/*
O ponto de entrada CFG10EGR permite outros tratamentos especํficos no momento da gravacao de inclusใo/altera็ใo/exclusใo dos parametros (SX6).
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ CFG10EGR บ Autor ณ   Felipe Pazetto   บ Data ณ  13/06/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ          ณ Ponto de entrada criado a fim de descobrir as cagadas de   บฑฑ
ฑฑบDescricao ณ quem poe a mao no SX6. O ponto de entrada eh disparado aposบฑฑ
ฑฑบ          ณ confirmar a tela de edicao do parametro.                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ   Uso    ณ Especifico Fini                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CFG10EGR()

Local cCodUser   := ParamIXB[1] 
Local cNomeUser  := ParamIXB[2] 
Local cOperacao  := ParamIXB[3] 
Local cParametro := ParamIXB[4]
Local aAlter     := ParamIXB[5]

//TODO Terminar essa porcaria de fonte

Do Case
	Case cOperacao == "3"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Parโmetro Criado!",  "Parโmetro: "+Alltrim(cParametro)+" criado pelo usuแrio:   "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conte๚do: "+aAlter[01][03])
	Case cOperacao == "4"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Parโmetro Alterado!","Parโmetro: "+Alltrim(cParametro)+" alterado pelo usuแrio: "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conte๚do antigo: "+aAlter[01][02]+" / Novo conte๚do: "+aAlter[01][03])
	Case cOperacao == "5"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Parโmetro Excluํdo!","Parโmetro: "+Alltrim(cParametro)+" excluํdo pelo usuแrio: "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conte๚do antigo: "+aAlter[01][01]+" / Novo conte๚do: "+aAlter[01][02]+" / Novo conte๚do: "+aAlter[01][03])
End

Return Nil