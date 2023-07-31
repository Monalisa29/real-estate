<%@page import="java.util.List"%>
<%@page import="DAO.QuestionnaireDBHelper"%>
<%@page import="helper.UserAccountHelper"%>
<%@page import="DAO.AccountDBHelper"%>
<%@page import="java.sql.SQLException"%>
<%@page import="bean.UserAccount"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
AccountDBHelper accountDBHelper = new AccountDBHelper();
UserAccountHelper userAccountHelper = new UserAccountHelper();
UserAccount currentUser = null;
String errorMessage = null;

String signinFromPage = (String) session.getAttribute("signinFromPage");
String email = request.getParameter("email");
String password = request.getParameter("password");
password = userAccountHelper.encryptionPassword(password);
QuestionnaireDBHelper questionnaireDBHelper = new QuestionnaireDBHelper();
List<Integer> usersForQuestionnaire = null;

if(!Objects.isNull(email) && !Objects.isNull(password))
{
	try{
		currentUser = accountDBHelper.getUserByEmailPassword(email, password);
		usersForQuestionnaire = questionnaireDBHelper.getUserForQuestionnaire();
		
		if(!Objects.isNull(currentUser))
		{
			if(currentUser.getAccountStatus().equals("activ") && currentUser.getUserType().equals("client"))
			{				
				session.setAttribute("currentUser", currentUser);
				if(usersForQuestionnaire.contains(currentUser.getUserId())){
					response.sendRedirect("questionnaire.jsp");
				}
				else{
					if(!Objects.isNull(signinFromPage) && "addI".equals(signinFromPage)){
						request.getSession().removeAttribute("signinFromPage");
						response.sendRedirect("addImmobile.jsp");
					}
					else if(!Objects.isNull(signinFromPage) && "tips".equals(signinFromPage)){
						request.getSession().removeAttribute("signinFromPage");
						response.sendRedirect("tipsPage.jsp");
					}
					else if(!Objects.isNull(signinFromPage) && "addFav".equals(signinFromPage)){
						String propertiesDetailLink = (String) session.getAttribute("propertiesDetailLink");
						request.getSession().removeAttribute("signinFromPage");
						request.getSession().removeAttribute("propertiesDetailLink");
						response.sendRedirect("properties_detail.jsp"+propertiesDetailLink);
					}
					else{
						response.sendRedirect("index.jsp");
					}
				}				
			}
			else
			{
				errorMessage = "Nu aveti acces cu acest cont!";
				response.sendRedirect("signin.jsp?mess="+errorMessage+"&e="+email);
			}
		}
		else
		{
			errorMessage = "Date de conectare invalide!";
			response.sendRedirect("signin.jsp?mess="+errorMessage+"&e="+email);
		}
	}
	catch(SQLException e){
		errorMessage = "Date de conectare invalide!";
		response.sendRedirect("signin.jsp?mess="+errorMessage+"&e="+email);
	}
}
else{
	errorMessage = "Date de conectare invalide!";
	response.sendRedirect("signin.jsp?mess="+errorMessage+"&e="+email);
}
%>