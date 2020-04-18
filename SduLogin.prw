#include "protheus.ch"
#include "Ap5Mail.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
��� Programa � SduLogin � Autor �   Felipe Pazetto   � Data �  12/07/16   ���
�������������������������������������������������������������������������͹��
��� Descricao� Audita o login no MPSDU via e-mail.                        ���
�������������������������������������������������������������������������͹��
���    Uso   � Pazetto                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function SduLogin()

	Local lRet 		:= .T.
	Local cMensagem:=	""
	Local cUser 	:=	ParamIXB

//Informe aqui o seu e-mail
	cMensagem	:=	"Usu�rio Protheus <b>" +Alltrim(cUser)+ "</b>�efetuou login no MPSDU atrav�s do usu�rio de rede <b> "
	cMensagem	+=	+Alltrim(LogUserName())+"</b> em "�+DtoC(Date())+ "��s " +Time()+ 
	cMensagem	+=	" na m�quina <b>"+Lower(ComputerName())+Upper(" (IP "+ GetClientIP()+" / PC: " +GetComputerName()+")</b>")
	
	cEmailPara	:=	"felipe@pazetto.net"
	U_SendMail(cEmailPara, "Login no MPSDU ", cMensagem )
	
Return .T.
