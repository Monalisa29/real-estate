<%@page import="java.util.Objects"%>
<%@page import="bean.UserAccount"%>
<%@page import="DAO.FavoriteAdsDBHelper"%>
<%
FavoriteAdsDBHelper favoriteAdsDBHelper = new FavoriteAdsDBHelper();
String adId = request.getParameter("adId");
String adCategoryId = request.getParameter("cat");
String fromPage = request.getParameter("from");
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
boolean hasAddedToFav = favoriteAdsDBHelper.hasAddedToFavorites(currentUser.getUserId(), Integer.parseInt(adId));

if(hasAddedToFav){
	favoriteAdsDBHelper.deleteAdFromFavorites(currentUser.getUserId(), Integer.parseInt(adId));
}
else{
	favoriteAdsDBHelper.insertAdToFavorites(currentUser.getUserId(), Integer.parseInt(adId));
}

if(!Objects.isNull(fromPage)){
	response.sendRedirect("myFavoritesList.jsp");
}
else{
	response.sendRedirect("properties_detail.jsp?id="+adId+"&cat="+adCategoryId);
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert or Delete Favorite</title>
</head>
<body>
</body>
</html>