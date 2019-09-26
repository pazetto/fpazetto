#include "protheus.ch"
#include "topconn.ch"

/*/{Protheus.doc} COMR013
Emissão de relatório de pedido para levantamento de custo net e gross.
@author    felipe.pazetto
@since     03/07/2019
@version   1.0
/*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ COMR013  ºAutor  ³ Felipe Pazetto	    º Data ³ 03/07/19 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Emissão de relatório de pedido para levantamento de custo  º±±
±±º          ³ net e gross.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COMR013()

	Private cCadastro	:=	"Relatorio de Pedidos x NF x CC"
	Private cPerg		:=	"COMR013"
	Private cQuery		:=	""
	Private nRec		:=	0

	Pergunte(cPerg,.T.)

	oReport := TReport():New("COMR013",cCadastro,cPerg,{|oReport| Imprime(oReport)},cCadastro) 	//Gera objeto do relatorio.
	oReport:ParamReadOnly(.F.)                   												//Define se o usuario tera acesso aos parametros do relatorio - .F. -> Permite
	oReport:SetLandscape()                       												//Define formato de paisagem
	oProd:=TrSection():New(oReport,cCadastro,{"TRB13"})											//Abertura da secao do objeto
	oProd:SetHeaderSection(.T.)																	//Define secao Cabecalho

	TrCell():New(oProd,"C7_FILIAL"    ,"TRB13","Filial"           		,PesqPict  ("SC7","C7_FILIAL"   ),TamSX3("C7_FILIAL" )[1],)
	TrCell():New(oProd,"C7_NUM"  	  ,"TRB13","Pedido"					,PesqPict  ("SC7","C7_NUM"  	),TamSX3("C7_NUM"    )[1],)
	TrCell():New(oProd,"C7_ITEM"      ,"TRB13","Item PC"				,PesqPict  ("SC7","C7_ITEM"  	),TamSX3("C7_ITEM"   )[1],)
	TrCell():New(oProd,"C7_PRODUTO"   ,"TRB13","Produto"				,PesqPict  ("SC7","C7_PRODUTO"	),TamSX3("C7_PRODUTO")[1],)
	TrCell():New(oProd,"C7_DESCRI"    ,"TRB13","Descrição"				,PesqPict  ("SC7","C7_DESCRI"	),TamSX3("C7_DESCRI" )[1],)
	TrCell():New(oProd,"C7_OBS"   	  ,"TRB13","Observação"				,PesqPict  ("SC7","C7_OBS"      ),TamSX3("C7_OBS"    )[1],)
	TrCell():New(oProd,"A2_NOME"      ,"TRB13","Razão Social"			,PesqPict  ("SA2","A2_NOME"   	),TamSX3("A2_NOME"   )[1],)
	TrCell():New(oProd,"C7_CC"        ,"TRB13","Centro Custo"			,PesqPict  ("SC7","C7_CC"     	),TamSX3("C7_CC"     )[1],)
	TrCell():New(oProd,"A2_EST"       ,"TRB13","UF"       				,PesqPict  ("SA2","A2_EST"   	),TamSX3("A2_EST"    )[1],)
	TrCell():New(oProd,"C7_CONAPRO"   ,"TRB13","Condição Aprov."		,PesqPict  ("SC7","C7_CONAPRO"	),TamSX3("C7_CONAPRO")[1],)
	TrCell():New(oProd,"NOMEUSR"   	  ,"TRB13","Usuário"				,PesqPict  ("SC7","C7_USER"     ),TamSX3("C7_USER"   )[1],)
	TrCell():New(oProd,"C7_MOEDA"     ,"TRB13","Moeda"     				,PesqPict  ("SC7","C7_NUM"	    ),TamSX3("C7_NUM"    )[1],)
	TrCell():New(oProd,"C7_EMISSAO"   ,"TRB13","Emissão PC" 			,PesqPict  ("SC7","C7_EMISSAO"	),TamSX3("C7_EMISSAO")[1],)
	TrCell():New(oProd,"C7_FORNECE"   ,"TRB13","Cód.Fornecedor"     	,PesqPict  ("SC7","C7_FORNECE"	),TamSX3("C7_FORNECE")[1],)
	TrCell():New(oProd,"C7_COND"      ,"TRB13","Cond.Pag"				,PesqPict  ("SC7","C7_COND"    	),TamSX3("C7_COND"   )[1],)
	TrCell():New(oProd,"E4_DESCRI"    ,"TRB13","Descrição Pagamento"	,PesqPict  ("SE4","E4_DESCRI"   ),TamSX3("E4_DESCRI" )[1],)
	TrCell():New(oProd,"C7_PRECO"     ,"TRB13","Valor Unit."			,PesqPictQt("C7_PRECO" 			),TamSX3("C7_PRECO"  )[1],)
	TrCell():New(oProd,"C7_QUANT"     ,"TRB13","Qtde."					,PesqPictQt("C7_QUANT"   	    ),TamSX3("C7_QUANT"  )[1],)
	TrCell():New(oProd,"C7_TOTAL"     ,"TRB13","Preço Total"			,PesqPictQt("C7_TOTAL" 		  	),TamSX3("C7_TOTAL"  )[1],)
	TrCell():New(oProd,"C7_VLDESC"    ,"TRB13","Vl.Desconto"			,PesqPictQt("C7_VLDESC"		  	),TamSX3("C7_VLDESC" )[1],)
	TrCell():New(oProd,"C7_VALICM"    ,"TRB13","Val.ICMS"				,PesqPictQt("C7_VALICM"   		),TamSX3("C7_VALICM" )[1],)
	TrCell():New(oProd,"C7_VALIMP5"   ,"TRB13","Val.PIS"				,PesqPictQt("C7_VALIMP5"  		),TamSX3("C7_VALIMP5")[1],)
	TrCell():New(oProd,"C7_VALIMP6"   ,"TRB13","Val.COFINS"				,PesqPictQt("C7_VALIMP6"  		),TamSX3("C7_VALIMP6")[1],)
	TrCell():New(oProd,"C7_VALIPI"    ,"TRB13","Val.IPI"				,PesqPictQt("C7_VALIPI"   		),TamSX3("C7_VALIPI" )[1],)
	TrCell():New(oProd,"C7_VALISS"    ,"TRB13","Val.ISS"				,PesqPictQt("C7_VALISS"   		),TamSX3("C7_VALISS" )[1],)
	TrCell():New(oProd,"C7_VALIR"     ,"TRB13","Val.IR"					,PesqPictQt("C7_VALIR"   		),TamSX3("C7_VALIR"  )[1],)
	TrCell():New(oProd,"C7_VALFRE"    ,"TRB13","Val.Frete"				,PesqPictQt("C7_VALFRE"   		),TamSX3("C7_VALFRE" )[1],)
	TrCell():New(oProd,"C7_SEGURO"    ,"TRB13","Val.Seguro"				,PesqPictQt("C7_SEGURO"   		),TamSX3("C7_SEGURO" )[1],)
	TrCell():New(oProd,"C7_DESPESA"   ,"TRB13","Val.Despesa"			,PesqPictQt("C7_DESPESA"   		),TamSX3("C7_DESPESA")[1],)

	oReport:PrintDialog()

Return


Static Function Imprime(oReport)

	Local oProd		:=	oReport:Section(1) //Objeto de sessão
	Local _cRotina	:= "COMR013"
	Local cMoeda	:= ""	
	Local cMoeda1	:= GetMv("MV_MOEDA1")
	Local cMoeda2	:= GetMv("MV_MOEDA2")
	Local cMoeda3	:= GetMv("MV_MOEDA3")
	Local cMoeda4	:= GetMv("MV_MOEDA4")
	Local cMoeda5	:= GetMv("MV_MOEDA5")
	Local cQuery 	:=	""

	oProd:Init() //Inicialização do objeto oProd

	If mv_par01 > mv_par02 .OR. mv_par03 > mv_par04 .OR. mv_par05 > mv_par06 .OR. mv_par07 > mv_par08
		MsgStop("Parâmetros informados incorretamente!",_cRotina)
		Return
	EndIf

	cQuery += " SELECT "
	cQuery += " C7_FILIAL "
	cQuery += " ,C7_NUM "
	cQuery += " ,C7_ITEM "
	cQuery += " ,C7_PRODUTO "
	cQuery += " ,C7_DESCRI "
	cQuery += " ,C7_OBS "
	cQuery += " ,C7_USER "
	cQuery += " ,C7_EMISSAO "
	cQuery += " ,CASE WHEN C7_CONAPRO='L' THEN 'Liberado' WHEN C7_CONAPRO='R' THEN 'Recusado' WHEN C7_CONAPRO='B' THEN 'Bloqueado' END AS C7_CONAPRO "
	cQuery += " ,C7_FORNECE "
	cQuery += " ,A2_NOME "
	cQuery += " ,A2_EST "
	cQuery += " ,C7_COND "
	cQuery += " ,E4_DESCRI "
	cQuery += " ,C7_CC "
	cQuery += " ,C7_PRECO "
	cQuery += " ,C7_QUANT "
	cQuery += " ,C7_TOTAL "
	cQuery += " ,C7_MOEDA "
	cQuery += " ,C7_VLDESC "
	cQuery += " ,C7_VALICM " 
	cQuery += " ,C7_VALIMP5 "
	cQuery += " ,C7_VALIMP6 "
	cQuery += " ,C7_VALIPI " 
	cQuery += " ,C7_VALISS " 
	cQuery += " ,C7_VALIR " 
	cQuery += " ,C7_VALFRE "
	cQuery += " ,C7_SEGURO "
	cQuery += " ,C7_DESPESA " 
	cQuery += " FROM "+RetSQLTab("SC7")+" "
	cQuery += " INNER JOIN "+RetSQLTab("SA2")+" ON C7_FORNECE = A2_COD "
	cQuery += " AND C7_LOJA = A2_LOJA "
	cQuery += " AND "+RetSQLDel("SA2")+" "
	cQuery += " INNER JOIN "+RetSQLTab("SB1")+" ON B1_COD=C7_PRODUTO "
	cQuery += " AND "+RetSQLDel("SB1")+" "
	cQuery += " INNER JOIN "+RetSQLTab("SE4")+" ON E4_CODIGO = C7_COND "
	cQuery += " AND "+RetSQLDel("SE4")+" "
	cQuery += " WHERE "+RetSQLDel("SC7")+" "
	cQuery += " AND C7_RESIDUO='' "
	cQuery += " AND C7_FILIAL BETWEEN '"+Alltrim(mv_par01)+"' AND '"+Alltrim(mv_par02)+"' "
	cQuery += " AND C7_CC BETWEEN '"+Alltrim(mv_par03)+"' AND '"+Alltrim(mv_par04)+"' "
	cQuery += " AND C7_EMISSAO BETWEEN '"+Alltrim(DtoS(mv_par05))+"' AND '"+Alltrim(DtoS(mv_par06))+"' "
	cQuery += " AND A2_COD BETWEEN '"+Alltrim(mv_par07)+"' AND '"+Alltrim(mv_par08)+"' "
	cQuery += " ORDER BY C7_EMISSAO "

	If Select("TRB13") > 0
		DbSelectArea("TRB13")
		TRB13->(DbCloseArea())
	EndIf

	TcQuery cQuery New Alias "TRB13"

	MemoWrite("C:\Temp\COMR013.sql",cQuery)

	Count to nRec

	oReport:SetMeter(nRec)

	DbSelectArea("TRB13")
	DbGoTop()
	While TRB13->(!Eof())
		If oReport:Cancel()
			Exit
		EndIf

		oReport:IncMeter()

		If TRB13->C7_MOEDA == 1   
			cMoeda  := cMoeda1
		ElseIf TRB13->C7_MOEDA == 2
			cMoeda  := cMoeda2
		ElseIf TRB13->C7_MOEDA == 3
			cMoeda  := cMoeda3
		ElseIf TRB13->C7_MOEDA == 4
			cMoeda  := cMoeda4
		ElseIf TRB13->C7_MOEDA == 5
			cMoeda  := cMoeda5
		EndIf

		oProd:Cell("C7_EMISSAO"):SetValue(DtoC(SToD(TRB13->C7_EMISSAO)))
		oProd:Cell("NOMEUSR"):SetValue(UsrRetName(TRB13->C7_USER))
		oProd:Cell("C7_MOEDA"):SetValue(cMoeda)

		oProd:PrintLine()

		TRB13->(DbSkip())
	End

	oProd:Finish()
	TRB13->(DbCloseArea())

Return