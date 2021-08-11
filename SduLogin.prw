#include "protheus.ch"
#include "Ap5Mail.ch"

/*/{Protheus.doc} SduLogin
Envia e-mail sobre auditoria de login no APSDU/MPSDU

@type function
@author Felipe Pazetto
@version P1180
@since 12/07/16
/*/

User Function SduLogin()

	Local lRet 		:= .T.
	Local cMensagem:=	""
	Local cUser 	:=	ParamIXB

//Informe aqui o seu e-mail
	cMensagem	:=	"Usuário Protheus <b>" +Alltrim(cUser)+ "</b> efetuou login no MPSDU através do usuário de rede <b> "
	cMensagem	+=	+Alltrim(LogUserName())+"</b> em " +DtoC(Date())+ " às " +Time()+ 
	cMensagem	+=	" na máquina <b>"+Lower(ComputerName())+Upper(" (IP "+ GetClientIP()+" / PC: " +GetComputerName()+")</b>")
	
	cEmailPara	:=	"felipe@pazetto.net"
	U_SendMail(cEmailPara, "Login no MPSDU ", cMensagem )
	
Return .T.
