#include "protheus.ch" 

User Function SPDFISBLCK()

Local aRet := {} 
Local dDataIni := PARAMIXB[1] 
Local dDataFin := PARAMIXB[2] 
Local cAliasK280 := ""

//----------------------------------------------------------------- 
//Cria alias e tabelas temporárias do bloco K 
//----------------------------------------------------------------- 
u_ProcessaK(@cAliasK280) 

//Adiciona alias das tabelas temporárias criadas 
aAdd(aRet,cAliasK280) 

Return aRet 

//------------------------------------------------------------------- 
/*/{Protheus.doc} ProcessaK 
Função para criação das tabelas temporárias para geração do bloco K 
/*/ 
//------------------------------------------------------------------- 
User Function ProcessaK(cAliasK280) 

Local aCampos   := {} 
Local nTamFil   := TamSX3("D1_FILIAL")[1] 
Local nTamDt    := TamSX3("D1_DTDIGIT")[1] 
Local aTamQtd   := TamSX3("B2_QATU") 
Local nTamOP    := TamSX3("D3_OP")[1] 
Local nTamCod   := TamSX3("B1_COD")[1] 
Local nTamChave := TamSX3("D1_COD")[1] + TamSX3("D1_SERIE")[1] + TamSX3("D1_FORNECE")[1] + TamSX3("D1_LOJA")[1]
Local nTamPar   := TamSX3("A1_COD")[1] + TamSX3("A1_LOJA")[1]
Local nTamReg   := 4 
Local cArqK280  := "" 

//-------------------------------------------- 
//Criacao do Arquivo de Trabalho - BLOCO K280
//-------------------------------------------- 
aCampos := {} 
AADD(aCampos,{"FILIAL" 	,"C",nTamFil 	,0}) 
AADD(aCampos,{"REG" 		,"C",nTamReg 	,0}) //Texto fixo contendo "K280"
AADD(aCampos,{"DT_EST" 	,"D",nTamDt 	,0}) //Data do estoque final escriturado que está sendo corrigido 
AADD(aCampos,{"COD_ITEM" 	,"C",nTamCod 	,0}) //Código do item (campo 02 do Registro 0200) 
AADD(aCampos,{"QTD_COR_P" 	,"C",nTamCod 	,0}) //Quantidade de correção positiva de apontamento ocorrido em período de apuração anterior
AADD(aCampos,{"QTD_COR_N" 	,"N",aTamQtd[1],aTamQtd[2]}) //Quantidade de correção negativa de apontamento ocorrido em período de apuração anterior 
AADD(aCampos,{"IND_EST" 	,"N",aTamQtd[1],aTamQtd[2]}) //Indicador do tipo de estoque 
AADD(aCampos,{"COD_PART" 	,"N",nTamPar 	,0 }) //Código do participante 

cAliasK280 	:= "K280" 
cArqK280 		:= CriaTrab(aCampos) 
DbUseArea(.T.,__LocalDriver,cArqK280, cAliasK280, .F., .F. ) 
IndRegua(cAliasK280,cArqK280,"FILIAL") 
DbSelectArea(cAliasK280) 
DbSetOrder(1)

Return

/*

Este exemplo irá gerar o bloco K da seguinte maneira:

|K001|0|
|K100|01012016|31012016|
|K200|31012016|500|1,000|0||
|K200|31012016|600|2,000|0||
|K230|01012016|04012016|00005001001|500|2,000|
|K235|01012016|600|8,000||
|K990|7|

Neste exemplo o registro 0210 fica da seguinte maneira:

0210    600 4,000000    
0

*/