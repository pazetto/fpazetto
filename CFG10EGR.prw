#include "totvs.ch"
#include "protheus.ch"
#include "topconn.ch"

/*
O ponto de entrada CFG10EGR permite outros tratamentos específicos no momento da gravacao de inclusão/alteração/exclusão dos parametros (SX6).
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ CFG10EGR º Autor ³   Felipe Pazetto   º Data ³  13/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º          ³ Ponto de entrada criado a fim de descobrir as cagadas de   º±±
±±ºDescricao ³ quem poe a mao no SX6. O ponto de entrada eh disparado aposº±±
±±º          ³ confirmar a tela de edicao do parametro.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Parâmetro Criado!",  "Parâmetro: "+Alltrim(cParametro)+" criado pelo usuário:   "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conteúdo: "+aAlter[01][03])
	Case cOperacao == "4"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Parâmetro Alterado!","Parâmetro: "+Alltrim(cParametro)+" alterado pelo usuário: "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conteúdo antigo: "+aAlter[01][02]+" / Novo conteúdo: "+aAlter[01][03])
	Case cOperacao == "5"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Parâmetro Excluído!","Parâmetro: "+Alltrim(cParametro)+" excluído pelo usuário: "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conteúdo antigo: "+aAlter[01][01]+" / Novo conteúdo: "+aAlter[01][02]+" / Novo conteúdo: "+aAlter[01][03])
End

Return Nil
