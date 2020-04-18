#include "TOTVS.CH"
#include "Ap5Mail.ch"
#include "topconn.ch"
#include "protheus.ch"
#include "SendMail.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ SendMail º Autor ³   Felipe Pazetto   º Data ³  17/04/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Descricao³ Faz o envio de mensagem automatica via e-mail.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º    Uso   ³ Pazetto                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function SendMail(cEmails, cTitulo, cTexto, cAnexo, cCCEmails, cCOEmails, cConta, cPass, cRemetente, cServer, nPorta, _lSSL, _lTSL, _SMTPTime)

	Local oServer
	Local oMessage
	Local nNumMsg     	:= 0
	Local nTam        	:= 0
	Local nI          	:= 0
	Local lRet			:= .T.
	Local aAnexos     	:= {}
	Local cTxtTMP     	:= ""
	Local i				:= 0
	
	Default cEmails		:= ""
	Default cTitulo		:= ""
	Default cTexto		:= ""
	Default cAnexo		:= ""
	Default cCCEmails	:= "" //E-mail Cópia
	Default cCOEmails	:= "" //E-mail Cópia Oculta
	Default cConta   	:= SuperGetMv("MV_RELACNT")
	Default cPass 		:= SuperGetMv("MV_RELPSW")
	Default cRemetente	:= SuperGetMv("MV_RELACNT")
	Default cServer    	:= Iif(!":"$SuperGetMv("MV_RELSERV"),SuperGetMv("MV_RELSERV"),SubStr(SuperGetMv("MV_RELSERV"),1,AT(":",SuperGetMv("MV_RELSERV"))-1))
	Default nPorta      := Val(iif(!":"$SuperGetMv("MV_RELSERV"),"587",SubStr(SuperGetMv("MV_RELSERV"),AT(":",SuperGetMv("MV_RELSERV"))+1,len(SuperGetMv("MV_RELSERV")))))
	Default _lSSL       := SuperGetMv("MV_RELSSL")
	Default _lTSL       := SuperGetMv("MV_RELTLS")
	Default _SMTPTime   := SuperGetMv("MV_RELTIME")
   
//Cria a conexão com o server STMP ( Envio de e-mail )
	oServer := tMailManager():New()
	oServer:SetUseSSL(_lSSL) 
	oServer:SetUseTLS(_lTSL) 
	oServer:Init( "", cServer, cConta, cPass, 0, nPorta )
   
//Seta um tempo de time out com servidor de 1min
	If oServer:SetSmtpTimeOut(_SMTPTime) != 0
		ConOut(STR0001)//"Falha ao setar o time out"
		lRet := .F.
		Return lRet
	EndIf
   
//Realiza a conexão SMTP
	n:=oServer:SmtpConnect()
	cErro := oServer:GetErrorString(n)
	If n!= 0
		ConOut(STR0002)
		lRet := .F.
		Return lRet
	EndIf
// Alterado a posição da autenticação após conetcar no SMTP
	oServer:SMTPAuth( cConta ,cPass ) // linha inserida por Júlio Soares em 03/07/2018

//Apos a conexão, cria o objeto da mensagem                             
	oMessage := tMailMessage():New()
   
//Limpa o objeto
	oMessage:Clear()
   
//Popula com os dados de envio
	oMessage:cFrom 	:= cConta
	oMessage:cTo 	:= cEmails
	
	If !Empty(cCCEmails)
		oMessage:cCc  := cCCEmails
	EndIf
	
	If !Empty(cCOEmails)	
		oMessage:cBcc  := cCOEmails
	EndIf
	
	oMessage:cSubject	:= cTitulo
	oMessage:cBody		:= cTexto
   
//+----------------------------------------+   
//|Adiciona um attach
//+----------------------------------------+
//23/01/2013 - Daniel Pitthan Silveira
//Verifica se existem mais de um arquivo para ser adcionado
//e adciona cada um idividualmente

	If !Empty(cAnexo)
	//Monta array de Anexos
		If AT(";",cAnexo)>0
			For i:=1 to Len(cAnexo)
				If Substr(cAnexo,i,1)==";"
					AADD(aAnexos,cTxtTmp)
					cTxtTmp:=""
				Else
					cTxtTMP+=Substr(cAnexo,i,1)
				EndIF
			Next
		
			For i:=1 to Len(aAnexos)
				If oMessage:AttachFile( aAnexos[i] ) < 0
					ConOut(STR0003)
					Return .F.
				Else
				//adiciona uma tag informando que é um attach e o nome do arq
					oMessage:AddAtthTag( aAnexos[i])
				EndIf
			Next
		Else
			If oMessage:AttachFile( cAnexo ) < 0
				ConOut(STR0003)
				Return .F.
			Else
				//adiciona uma tag informando que é um attach e o nome do arq
				oMessage:AddAtthTag(cAnexo)
			EndIf
		EndIf
	EndIf
   
//Envia o e-mail
	n := oMessage:Send( oServer )

	cErro := oServer:GetErrorString(n)

	If n != 0
		ConOut(STR0004+cErro )
		lRet := .F.
		//Return lRet
	EndIf
   
  //Desconecta do servidor
	If oServer:SmtpDisconnect() != 0
		ConOut(STR0005)
		lRet := .F.
		Return lRet
	EndIf

Return lRet