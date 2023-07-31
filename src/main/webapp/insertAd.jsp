<%@page import="DAO.AdDBHelper"%>
<%@page import="bean.UserAccount"%>
<%@page import="java.util.Objects"%>
<%@page import="helper.ImmobileHelper"%>
<%@page import="bean.AdImmobile"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%
int successInsert = 0;
int errMessageTitle = 0;
int errMessagePrice = 0;
int errMessageCategory = 0;
int errMessageType = 0;
int errMessagePart = 0;
int errMessageFloorAp = 0;
int errMessageFloorsHouse = 0;
int errMessagePostingPer = 0;

String immobileId = (String) session.getAttribute("immobileId");
request.getSession().removeAttribute("immobileId");
String title = request.getParameter("title");
String price = request.getParameter("price");
String category = request.getParameter("category");
String type = request.getParameter("type");
String postingPeriod = request.getParameter("postingPeriod");

AdImmobile adImmobile = new AdImmobile();
ImmobileHelper immobileHelper = new ImmobileHelper();
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
AdDBHelper adDBHelper = new AdDBHelper();
adImmobile = immobileDBHelper.getImmobileById(Integer.parseInt(immobileId));

int priceParse = immobileHelper.getSelectedNr(price);
int postingPeriodParse = immobileHelper.getSelectedNr(postingPeriod);

if(Objects.isNull(title) || title.equals("") || title.length() <= 10)
{
	errMessageTitle = 1;
}
if(priceParse == 0 || priceParse == -1)
{
	errMessagePrice = 1;
}
if(Objects.isNull(category) || category.equals(""))
{
	errMessageCategory = 1;
}
if(Objects.isNull(type) || type.equals(""))
{
	errMessageType = 1;
}
if(postingPeriodParse == 0 || postingPeriodParse == -1)
{
	errMessagePostingPer = 1;
}

if(errMessageTitle == 0 && errMessagePrice == 0 && errMessageCategory == 0 && errMessageType == 0 && errMessagePart == 0 && errMessageFloorAp == 0 && errMessageFloorsHouse == 0 && errMessagePostingPer == 0){
	adImmobile.setAdTitle(title);
	adImmobile.setPriceImmobile(Integer.parseInt(price)); 
	adImmobile.setAdStatus("in asteptare");
	adImmobile.setRealtorId(adDBHelper.getRealtorAd());
	adImmobile.setAdPostingPeriod(postingPeriodParse);
	adImmobile.setCategoryName(category);
	adImmobile.setImmobileType(type);
	adImmobile.setCategoryId(adDBHelper.getCategoryId(adImmobile.getCategoryName(), adImmobile.getImmobileType()));
	
	successInsert = adDBHelper.insertAd(adImmobile);
}
response.sendRedirect("myAds.jsp?mess="+successInsert);
%>