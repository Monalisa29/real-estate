<%@page import="java.sql.SQLException"%>
<%@page import="DAO.AccountDBHelper"%>
<%@page import="java.util.Objects"%>
<%@page import="helper.UserAccountHelper"%>
<%@page import="bean.UserAccount"%>
<%@page import="helper.ImmobileHelper"%>
<%
ImmobileHelper immobileHelper = new ImmobileHelper();
UserAccountHelper userAccountHelper = new 	UserAccountHelper();
AccountDBHelper accountDBHelper = new AccountDBHelper();
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
String phoneNr = request.getParameter("phoneNr");
String oldPassword = request.getParameter("oldPassword");
oldPassword = userAccountHelper.encryptionPassword(oldPassword);
String newPassword = request.getParameter("newPassword");
newPassword = userAccountHelper.encryptionPassword(newPassword);
int successUpdate = 0;

try{
	if((!Objects.isNull(phoneNr) && !phoneNr.equals("")) && phoneNr.matches("[0-9]+")){
		if(!userAccount.getUserPhoneNr().equals(phoneNr)){
	successUpdate = accountDBHelper.updateUserPhoneNr(userAccount.getUserId(), phoneNr);
	request.getSession().removeAttribute("currentUser");
	userAccount = accountDBHelper.getUserByEmailPassword(userAccount.getEmail(), userAccount.getPassword());
	session.setAttribute("currentUser", userAccount);
		}
		if(!Objects.isNull(oldPassword) && !oldPassword.equals("") && !Objects.isNull(newPassword) && !newPassword.equals("")){
	if(userAccount.getPassword().equals(oldPassword) && newPassword.length() > 4){
		successUpdate = accountDBHelper.updateUserPassword(userAccount.getUserId(), newPassword);
		request.getSession().removeAttribute("currentUser");
		response.sendRedirect("signin.jsp");
	}
	else{
		response.sendRedirect("myProfile.jsp?mess="+3);
	}
		}
		else{
	response.sendRedirect("myProfile.jsp?mess="+successUpdate);
		}
		
	}
	else{
		response.sendRedirect("myProfile.jsp?mess="+2);
	}
}
catch(SQLException e){
	response.sendRedirect("myProfile.jsp?mess="+0);
}
%>