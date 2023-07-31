<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="org.apache.tomcat.util.http.fileupload.IOUtils"%>
<%@page import="java.io.InputStream"%>
<%@page import="bean.UserAccount"%>
<%@page import="java.sql.SQLException"%>
<%@page import="DAO.AddressDBHelper"%>
<%@page import="java.util.Objects"%>
<%@page import="helper.ImmobileHelper"%>
<%@page import="bean.AdImmobile"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="javax.servlet.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.io.output.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%
String sqlException = null;
int successInsert = 0;
int errMessageArea = 0;
int errMessageDesc = 0;
int errMessageYear = 0;
int errMessageCounty = 0;
int errMessageCity = 0;
int errMessageStreetN = 0;
int errMessageAdressNr = 0;
int errMessagePart = 0;
int errMessageFloorNrAp = 0;
int errMessageFloorsNrH = 0;

UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
ImmobileHelper immobileHelper = new ImmobileHelper();
AdImmobile immobile = new AdImmobile();
AddressDBHelper adressDBHelper = new AddressDBHelper();

String usableArea = null;
String description = null;
String year = null;
String roomsNr = null;
String county = null;
String city = null;
String streetName = null;
String adressNr = null;
String category = null;
String floorAp = null;
String floorsNrHouse = null;
String partitioning = null;

DiskFileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> items = upload.parseRequest(request);
String fileName = "";

for (FileItem item : items) {
 if (item.isFormField()) {
     String fieldName = item.getFieldName();
     String fieldValue = item.getString();
     
     if(fieldName.equals("usableArea")){
    	 usableArea = fieldValue;
     }
     if(fieldName.equals("description")){
    	 description = fieldValue;
     }
     if(fieldName.equals("year")){
    	 year = fieldValue;
     }
     if(fieldName.equals("roomsNr")){
    	 roomsNr = fieldValue;
     }
     if(fieldName.equals("county")){
    	 county = fieldValue;
     }
     if(fieldName.equals("city")){
    	 city = fieldValue;
     }
     if(fieldName.equals("streetName")){
    	 streetName = fieldValue;
     }
     if(fieldName.equals("adressNr")){
    	 adressNr = fieldValue;
     }
     if(fieldName.equals("category")){
    	 category = fieldValue;
     }
     if(fieldName.equals("floorAp")){
    	 floorAp = fieldValue;
     }
     if(fieldName.equals("floorsNrHouse")){
    	 floorsNrHouse = fieldValue;
     }
     if(fieldName.equals("partitioning")){
    	 partitioning = fieldValue;
     }
     
 } 
 else{
	 fileName = item.getName();
	 if (fileName != null && !fileName.isEmpty()) {
	String fileType = item.getContentType();
		    fileName = Integer.toString(immobileDBHelper.getNextIdImmobile()) + ".jpg";
	        File file = new File("C:/Users/Monalisa/Documents/Licenta/WebApp/src/main/webapp/img/immobileImages", fileName);
	        item.write(file);
	    }
 }
}

int usableAreaInt = immobileHelper.getSelectedUsableArea(usableArea);
int yearNr = immobileHelper.getSelectedNr(year);
int roomsNrParse = immobileHelper.getSelectedNr(roomsNr);
int adressNrParse = immobileHelper.getSelectedNr(adressNr);
int floorApParse = immobileHelper.getSelectedNr(floorAp);
int floorsNrHParse = immobileHelper.getSelectedNr(floorsNrHouse);
boolean streetNameContainsSpecialChars = immobileHelper.checkIfContainsSpecialChars(streetName);

if(usableAreaInt == -1 || usableAreaInt == 0){
	errMessageArea = 1;
}
if(Objects.isNull(description) || description.equals("") ){
	errMessageDesc = 1;
}
if(yearNr == -1){
	errMessageYear = 1;
}
if(Objects .isNull(county) || county.equals("")){
	errMessageCounty = 1;
}
if(Objects.isNull(city) || city.equals("")){
	errMessageCity = 1;
}
if(streetNameContainsSpecialChars){
	errMessageStreetN = 1;
}
if(adressNrParse == 0 || adressNrParse == -1){
	errMessageAdressNr = 1;
}
if(Objects.isNull(partitioning) || partitioning.equals("")){
	errMessagePart = 1;
}
if(category.equals("ApartamentGarsoniera") && (floorApParse == 0 || floorApParse == -1)){
	errMessageFloorNrAp = 1;
}
if(category.equals("Casa") && floorsNrHParse == -1){
	errMessageFloorsNrH = 1;
}

try{
	if(errMessageArea == 0 && errMessageDesc == 0 && errMessageYear == 0 && errMessageCounty == 0 && errMessageCity == 0 && errMessageAdressNr == 0 && errMessageStreetN == 0 && errMessageFloorNrAp == 0 && errMessageFloorsNrH == 0)
	{
		immobile.setUsableArea(usableAreaInt);
		immobile.setDescImmobile(description);
		immobile.setYearImmobile(yearNr);
		immobile.setRoomsNrImmobile(roomsNrParse);
		immobile.setCounty(county);
		immobile.setCity(city);
		immobile.setStreedName(streetName);
		immobile.setAddressNr(adressNrParse);
		immobile.setUserId(userAccount.getUserId());
		immobile.setCategoryName(category);
		immobile.setPicture(fileName);
		
		if(immobileDBHelper.checkIfAddressExist(immobile) == -1)
		{
			adressDBHelper.insertAddress(immobile);
		}
		immobile.setAddressId(immobileDBHelper.checkIfAddressExist(immobile));
	
		
		if(immobile.getCategoryName().equals("ApartamentGarsoniera")){
			immobile.setPartitioningAp(partitioning);
			immobile.setFloorAp(floorApParse);
		}
		else if(immobile.getCategoryName().equals("Casa")){
			immobile.setFloorsNrHouse(floorsNrHParse);
		}		
		
		successInsert = immobileDBHelper.insertImmobile(immobile);
	}
}
catch(SQLException e)
{
	  sqlException = e.getMessage();
}

response.sendRedirect("addImmobile.jsp?mess="+successInsert);
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Adauga imobil</title>
</head>
<body>
</body>
</html>