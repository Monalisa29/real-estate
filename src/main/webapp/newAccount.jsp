<%@page import="bean.UserAccount"%>
<%@page import="DAO.AccountDBHelper"%>
<%@page import="java.util.Objects"%>
<%@page import="java.sql.SQLException"%>
<%@page import="helper.UserAccountHelper"%>
<%
UserAccountHelper userAccountHelper = new UserAccountHelper();
AccountDBHelper accountDBHelper = new AccountDBHelper();
UserAccount userAccount = new UserAccount();
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String password = request.getParameter("password");
String cnp = request.getParameter("cnp");
String sex = request.getParameter("sex");
String phoneNr = request.getParameter("phoneNr");
password = userAccountHelper.encryptionPassword(password);
String confirmPassword = request.getParameter("confirm-password");
confirmPassword = userAccountHelper.encryptionPassword(confirmPassword);
int insertAccountStatus = 0;
boolean checkIfEmailExist = accountDBHelper.checkIfEmailExist(email);

try{
	if(!Objects.isNull(phoneNr) && !phoneNr.equals("") && !Objects.isNull(fname) && !fname.equals("") && !Objects.isNull(lname) && !lname.equals("") && !Objects.isNull(cnp) && !cnp.equals("") && !Objects.isNull(sex) && !sex.equals("") && !Objects.isNull(email) && !email.equals("") && !Objects.isNull(password) && !password.equals("") && !Objects.isNull(confirmPassword) && !confirmPassword.equals("")){
		if(!checkIfEmailExist){
			if(fname.matches("[a-zA-Z]+") && lname.matches("[a-zA-Z]+") && cnp.matches("[0-9]+") && phoneNr.matches("[0-9]+") && (email.endsWith("@yahoo.com") || email.endsWith("@gmail.com")) && password.equals(confirmPassword) && password.length() > 4 && cnp.length() == 13 ){
				userAccount.setUserLName(lname);
				userAccount.setUserFName(fname);
				userAccount.setUserCNP(cnp);
				userAccount.setUserSex(sex.charAt(0));
				userAccount.setUserPhoneNr(phoneNr);
				userAccount.setEmail(email);
				userAccount.setPassword(password);
				userAccount.setUserType("client");
				userAccount.setAccountStatus("activ");
				insertAccountStatus = accountDBHelper.insertUser(userAccount);
				
				response.sendRedirect("register.jsp?mess="+insertAccountStatus);
			}
		}
		else{
			response.sendRedirect("register.jsp?mess="+3);
		}
	}
	else{
		response.sendRedirect("register.jsp?mess="+insertAccountStatus);
	}
}
catch(SQLException e){
	System.out.println(e.getMessage());
	response.sendRedirect("register.jsp?mess="+2);
}

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inregistrare cont</title>
</head>
<body>

</body>
</html>