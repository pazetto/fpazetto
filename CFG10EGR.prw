#include "totvs.ch"
#include "protheus.ch"
#include "topconn.ch"

/*
O ponto de entrada CFG10EGR permite outros tratamentos espec�ficos no momento da gravacao de inclus�o/altera��o/exclus�o dos parametros (SX6).
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
��� Programa � CFG10EGR � Autor �   Felipe Pazetto   � Data �  13/06/16   ���
�������������������������������������������������������������������������͹��
���          � Ponto de entrada criado a fim de descobrir as cagadas de   ���
���Descricao � quem poe a mao no SX6. O ponto de entrada eh disparado apos���
���          � confirmar a tela de edicao do parametro.                   ���
�������������������������������������������������������������������������͹��
���   Uso    � Especifico Fini                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Par�metro Criado!",  "Par�metro: "+Alltrim(cParametro)+" criado pelo usu�rio:   "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conte�do: "+aAlter[01][03])
	Case cOperacao == "4"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Par�metro Alterado!","Par�metro: "+Alltrim(cParametro)+" alterado pelo usu�rio: "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conte�do antigo: "+aAlter[01][02]+" / Novo conte�do: "+aAlter[01][03])
	Case cOperacao == "5"
		u_SCEMail(GetMV("ZZ_ALTPARA"),"Par�metro Exclu�do!","Par�metro: "+Alltrim(cParametro)+" exclu�do pelo usu�rio: "+Alltrim(cCodUser)+" "+Alltrim(cNomeUser)+". Conte�do antigo: "+aAlter[01][01]+" / Novo conte�do: "+aAlter[01][02]+" / Novo conte�do: "+aAlter[01][03])
End

Return Nil