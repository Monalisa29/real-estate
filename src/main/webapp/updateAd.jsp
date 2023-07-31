<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%@page import="DAO.AdDBHelper"%>
<%@page import="helper.ImmobileHelper"%>
<%@page import="java.util.Objects"%>
<%
String title = request.getParameter("title");
String description = request.getParameter("description");
String price = request.getParameter("price");
String adId = request.getParameter("hiddenId");
String categoryId = request.getParameter("hiddenCategory");
String status = request.getParameter("status");

ImmobileHelper immobileHelper = new ImmobileHelper();
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
AdDBHelper  adDBHelper = new AdDBHelper();
AdImmobile adImmobile = adDBHelper.getAdImmobileById(Integer.parseInt(adId), Integer.parseInt(categoryId));
int errorMessage = 0;
int validationTitle = 0;
int validationDescription = 0;
int validationPrice = 0;
int messageUpdateAd = 0;
int messageUpdateImmobile = 0;
validationPrice = immobileHelper.getSelectedNr(price);

if(Objects.isNull(title) || title.equals("") || title.length() <= 10)
{
	validationTitle = 1;
}
if(validationPrice == 0 || validationPrice == -1)
{
	validationPrice = 1;
}
else{
	validationPrice = 0;
}
if(Objects.isNull(description) || description.equals(""))
{
	validationDescription = 1;
}

if(validationTitle == 0 && validationDescription == 0 && validationPrice == 0 && !Objects.isNull(adId)){
	adImmobile.setAdTitle(title);
	adImmobile.setDescImmobile(description);
	adImmobile.setPriceImmobile(Integer.parseInt(price));
	adImmobile.setAdStatus(status);
	
	messageUpdateAd = adDBHelper.updateAd(adImmobile);
	messageUpdateImmobile = immobileDBHelper.updateDesciptionImmobile(adImmobile);
	
	if(messageUpdateAd == 1 && messageUpdateImmobile == 1){
		response.sendRedirect("myAds.jsp?messU=1");
	}
	else{
		response.sendRedirect("myAds.jsp?messU=0");
	}
}
else{
	errorMessage = 1;
	response.sendRedirect("modifyAd.jsp?id="+adId+"&cat="+categoryId+"&err="+errorMessage);
}

%>