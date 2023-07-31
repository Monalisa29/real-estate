<%@page import="helper.UserAccountHelper"%>
<%@page import="java.util.Objects"%>
<%@page import="bean.UserAccount"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="helper.SendEmailHelper"%>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");
String subject = request.getParameter("subject");
String comment = request.getParameter("comment");
UserAccountHelper accountHelper = new UserAccountHelper();

SendEmailHelper emailHelper = new SendEmailHelper();
int errorEmailSend = 0;

try{
	emailHelper.sendEmailContact(email, password, subject, comment);
	errorEmailSend = 1;
	response.sendRedirect("contact.jsp?send="+errorEmailSend);
}
catch(MessagingException e){
	response.sendRedirect("contact.jsp?send="+errorEmailSend);
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Trimitere email</title>
</head>
<body>
</body>
</html>