<%@page import="DAO.CommentDBHelper"%>
<%@page import="bean.Comment"%>
<%@page import="java.util.Objects"%>
<%@page import="bean.UserAccount"%>
<%
int successInsert = 0;
int errorMessComment = 0;
String commentText = request.getParameter("commentText");
CommentDBHelper commentDBHelper = new CommentDBHelper();
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
Comment comment = new Comment();

if(Objects.isNull(commentText) || commentText.equals("") || commentText.length() < 10)
{
	errorMessComment = 1;
}
else{
	comment.setCommentText(commentText);
	comment.setUserId(userAccount.getUserId());
	
	successInsert = commentDBHelper.insertComment(comment);
}
response.sendRedirect("tipsPage.jsp?mess="+successInsert);
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Posteaza comentariu</title>
</head>
<body>
</body>
</html>