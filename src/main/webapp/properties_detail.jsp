<%@page import="DAO.FavoriteAdsDBHelper"%>
<%@page import="bean.UserAccount"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Objects"%>
<%@page import="DAO.AdDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>   
<%
boolean hasAddedToFavorites = false;
String sqlException = null;

String adId = request.getParameter("id");
String adCategoryId = request.getParameter("cat");

AdImmobile adImmobile = new AdImmobile();
AdDBHelper adDBHelper = new AdDBHelper();
FavoriteAdsDBHelper favoriteAdsDBHelper = new FavoriteAdsDBHelper();
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");

int nrUserWhoAddFavorite = favoriteAdsDBHelper.nrUserWhoAddFavorite(Integer.parseInt(adId));

if(!Objects.isNull(adId) && !Objects.isNull(adCategoryId)){
	try{
		adImmobile = adDBHelper.getAdImmobileById(Integer.parseInt(adId), Integer.parseInt(adCategoryId));
		
		if(!Objects.isNull(currentUser)){
			hasAddedToFavorites = favoriteAdsDBHelper.hasAddedToFavorites(currentUser.getUserId(), Integer.parseInt(adId));
		}		
	}
	catch(SQLException e)
    {
	    sqlException = e.getMessage();
    }
	
	if(sqlException != null){
		response.sendRedirect("404.jsp");
	}
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor| Detalii anunt</title>

    <!-- Favicon -->
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
     
    <!-- Font awesome -->
    <link href="css/font-awesome.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="css/bootstrap.css" rel="stylesheet">   
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="css/nouislider.css">
    <!-- Fancybox slider -->
    <link rel="stylesheet" href="css/jquery.fancybox.css" type="text/css" media="screen" /> 
    <!-- Theme color -->
    <link id="switcher" href="css/theme-color/default-theme.css" rel="stylesheet">     

    <!-- Main style sheet -->
    <link href="css/style.css" rel="stylesheet">    
  
    <!-- Google Font -->
    <link href='https://fonts.googleapis.com/css?family=Vollkorn' rel='stylesheet' type='text/css'>    
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
  <style>
	.detailsTable {
	  border-collapse: collapse;
	  width: 50%;
	}
	.detailsTable td,th{
      padding: 9px;
  	  text-align: left;
      border-bottom: 2px solid #ddd;
	}
	
	.favorite-button {
      display: inline-block;
      position: relative;
	}
	.favorite-button .favorite-icon {
	  position: absolute;
	  background-position: center;
  	  background-repeat: no-repeat;  	  
	  cursor: pointer;
	}
	.favorite-icon.favorite {
	  background-image: url(img/icons/favorite-red.png);
	  background-size: contain;
	  background-repeat: no-repeat;
	  background-position: center;
	}
	.nrUsers{
	  font-size: 10px;
	}
	.aa-properties-details-img {
	  position: relative;
	}
	.favorite-details {
	  position: absolute;
	  top: 0;
	  left: 10;
	  background-color: rgba(0, 0, 0, 0.6);
	  color: white;
	  display: flex;
	  flex-direction: column;
	  justify-content: center;
	  align-items: center;
	  padding-bottom: 2px;
	  padding-right: 23px;
	  padding-top: 8px;
	  padding-left: 9px;
	  margin: 0;
	  font-size: 13px;
	  z-index: 2;
	  border-radius: 10px;
	}
	.favorite-button img {
	  vertical-align: middle;
	  margin-left: 6px; 
	}
</style>
<script> 
document.addEventListener("DOMContentLoaded", function() {
	  const favoriteButton = document.querySelector(".favorite-button");
	  const favoriteIcon = document.querySelector(".favorite-icon");

	  favoriteButton.addEventListener("click", function() {
		  <% if(!Objects.isNull(currentUser)) { %> 
		  
	    const isFavorite = favoriteIcon.classList.contains("favorite");
	    if (isFavorite) {
	      favoriteIcon.classList.remove("favorite");
	      favoriteIcon.src = "img/icons/favorite.png";	 
	      deleteFavorite();
	    } else {
	      favoriteIcon.classList.add("favorite");
	      favoriteIcon.src = "img/icons/favorite-red.png";
	      insertFavorite();
	    }	   
	    
	    <% } else { %>
	    <% session.setAttribute("signinFromPage", "addFav"); 
	       session.setAttribute("propertiesDetailLink", "?id="+adId+"&cat="+adCategoryId); %>
	      window.location.href = "signin.jsp";
	    <% } %>
	  });  	 
	   	  
	});
function deleteFavorite(){
	<% if(!Objects.isNull(currentUser)) { %> 
	  window.location.href = "insertDeleteFavotite.jsp?adId="+<%=adId%>+"&cat="+<%=adCategoryId%>;
	  <%}%>
}

function insertFavorite(){
	<% if(!Objects.isNull(currentUser)) { %> 
	  window.location.href = "insertDeleteFavotite.jsp?adId="+<%=adId%>+"&cat="+<%=adCategoryId%>;
	  <%}%>
}
	
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head>
  <body class="aa-price-range">  
  <!-- SCROLL TOP BUTTON -->
    <a class="scrollToTop" href="#"><i class="fa fa-angle-double-up"></i></a>
  <!-- END SCROLL TOP BUTTON -->

  <!-- Start header section -->
  <header id="aa-header">  
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-header-area">
            <div class="row">
              <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="aa-header-left">
                  <div class="aa-telephone-no">
                    <span class="fa fa-phone"></span>
                    1-900-523-3564
                  </div>
                  <div class="aa-email hidden-xs">
                    <span class="fa fa-envelope-o"></span> homestor@gmail.com
                  </div>
                </div>              
              </div>
              <%if(Objects.isNull(currentUser)){ %>
              <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="aa-header-right">
                  <a href="register.jsp" class="aa-register">Inregistreaza-te</a>
                  <a href="signin.jsp" class="aa-login">Conecteaza-te</a>
                </div>
              </div>
              <%} %>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
  <!-- End header section -->
  <!-- Start menu section -->
  <section id="aa-menu-area">
    <nav class="navbar navbar-default main-navbar" role="navigation">  
      <div class="container">
        <div class="navbar-header">
          <!-- FOR MOBILE VIEW COLLAPSED BUTTON -->
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <!-- LOGO -->                                               
          <!-- Text based logo -->
          <a class="navbar-brand aa-logo" href="index.jsp"> Home <span>Stor</span></a>
          <!-- Image based logo -->
          <!-- <a class="navbar-brand aa-logo-img" href="index.jsp"><img src="img/logo.png" alt="logo"></a> -->                     
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul id="top-menu" class="nav navbar-nav navbar-right aa-main-nav">
            <li><a href="index.jsp">ACASA</a></li>
             <li class="dropdown active">
              <a class="dropdown-toggle" data-toggle="dropdown" href="">ANUNTURI <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">                
                <li><a href="searchImmobile.jsp">CAUTA ANUNTURI</a></li>
                <li><a href="addImmobile.jsp">POSTEAZA ANUNT</a></li>                                            
              </ul>
            </li>
            <li><a href="gallery.jsp">GALERIE</a></li>                                         
            <li><a href="tipsPage.jsp">SFATURI </a></li>
            <li><a href="contact.jsp">CONTACT</a></li>
            <%if(!Objects.isNull(currentUser)){ %>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="">CONTUL MEU <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">       
                <li><a href="myProfile.jsp">PROFILUL MEU</a></li>           
                <li><a href="myRealEstates.jsp">IMOBILELE MELE</a></li>
                <li><a href="myAds.jsp">ANUNTURILE MELE</a></li>      
                <li><a href="myFavoritesList.jsp">LISTA DE FAVORITE</a></li>   
                <li><a href="logout.jsp">DECONECTEAZA-TE</a></li>                                        
              </ul>
            </li>
            <%} %>
            </li>
          </ul>                           
        </div><!--/.nav-collapse -->      
      </div>          
    </nav> 
  </section>
  <!-- End menu section -->

  <!-- Start Proerty header  -->
  <section id="aa-property-header">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-property-header-inner">
            <h2>Detalii anunt</h2>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->

  <!-- Start Properties  -->
  <section id="aa-properties">
    <div class="container">
      <div class="row">
        <div class="col-md-8">
          <div class="aa-properties-content">            
            <!-- Start properties content body -->
            <div class="aa-properties-details">   
            <%if(!Objects.isNull(currentUser) && currentUser.getUserId() != adImmobile.getUserId()){ %>
            <div class="favorite-details">
	            <%if(hasAddedToFavorites){ %>
	            <p class="favorite-button">Adauga la favorite  <img src="img/icons/favorite-red.png" alt="img" class="favorite-icon favorite"></p>
	            <%} else{ %>
	            <p class="favorite-button">Adauga la favorite  <img src="img/icons/favorite.png" alt="img" class="favorite-icon"></p>
	            <%} %>
	            <%if(nrUserWhoAddFavorite == 1){ %>
	            <p class="nrUsers"><%=nrUserWhoAddFavorite%> persoana urmareste acest anunt</p>
	            <%} %>
	            <%if(nrUserWhoAddFavorite != 1){ %>
	            <p class="nrUsers"><%=5 + nrUserWhoAddFavorite%> persoane urmaresc acest anunt</p>
	            <%} %>
            </div>      
            <%} else if (Objects.isNull(currentUser)){%>    
                <div class="favorite-details">
	            <%if(hasAddedToFavorites){ %>
	            <p class="favorite-button">Adauga la favorite  <img src="img/icons/favorite-red.png" alt="img" class="favorite-icon favorite"></p>
	            <%} else{ %>
	            <p class="favorite-button">Adauga la favorite  <img src="img/icons/favorite.png" alt="img" class="favorite-icon"></p>
	            <%} %>
	            <%if(nrUserWhoAddFavorite == 1){ %>
	            <p class="nrUsers"><%=nrUserWhoAddFavorite%> persoana urmareste acest anunt</p>
	            <%} %>
	            <%if(nrUserWhoAddFavorite != 1){ %>
	            <p class="nrUsers"><%=5 + nrUserWhoAddFavorite%> persoane urmaresc acest anunt</p>
	            <%} %>
            </div>   
            <%} %>
            <div class="aa-properties-details-img">         
               <img src="img/immobileImages/<%=adImmobile.getPicture() %>" alt="img">                    
               </div>               
               <p><img src="img/icons/location.png">    
                  <%=adImmobile.getCounty() + " - " + adImmobile.getCity() + ", str. " + adImmobile.getStreedName() + " nr. " + adImmobile.getAddressNr()%></p>
             <div class="aa-properties-info">
               <h2><%=adImmobile.getAdTitle() %></h2>
               <span class="aa-price"> Pret de <%if(adImmobile.getImmobileType().equals("Vanzare")){%> vanzare: <%}else{%> inchiriere: <%} %> <%=adImmobile.getPriceImmobile() %> LEI</span>
               <p>Descriere:</p>
               <p><%=adImmobile.getDescImmobile() %></p>
               <h4>Caracteristicile imobilului:</h4>
               <table class="detailsTable">
                 <tr>
				   <td><img src="img/icons/category.png"> Categorie</td>
				   <td><%=adImmobile.getCategoryName() %></td>
				</tr>
				<tr>
				   <td><img src="img/icons/category.png"> Tip</td>
				   <td><%=adImmobile.getImmobileType() %></td>
				</tr>				
				<tr>
				   <td><img src="img/icons/area.png"> Suprafata utila</td>
				   <td><%=adImmobile.getUsableArea() %> mp</td>
				</tr>
				<%if(adImmobile.getRoomsNrImmobile() != 0){ %>
               	 <tr>
				   <td><img src="img/icons/rooms.png"> Nr. camere</td>
				   <td><%=adImmobile.getRoomsNrImmobile() %></td>
				</tr>
				<%} %>
				<%if(adImmobile.getCategoryId() == 1 || adImmobile.getCategoryId() == 2){ %>
				  <tr>
				   <td><img src="img/icons/partitioning.png">Compartimentare</td>
				   <td><%=adImmobile.getPartitioningAp() %></td>
				  </tr>
				  <tr>
				   <td><img src="img/icons/stairs.png"> Etaj</td>
				   <td><%=adImmobile.getFloorAp() %></td>
				  </tr>
				<%} %>
				<%if(adImmobile.getCategoryId() == 3 || adImmobile.getCategoryId() == 4){ %>
				  <tr>
				   <td><img src="img/icons/stairs.png"> Nr. etaje</td>
				   <td><%=adImmobile.getFloorsNrHouse() %></td>
				  </tr>
				<%} %>
				<%if(adImmobile.getYearImmobile() != 0){ %>
               	 <tr>
				   <td><img src="img/icons/year.png"> Anul constructiei</td>
				   <td><%=adImmobile.getYearImmobile() %></td>
				</tr>
				<%} %>	
               </table>
               </div>

            </div>         
          </div>          
        </div>     
        <!-- Start properties sidebar -->
        <%if(Objects.isNull(currentUser) || adImmobile.getUserId() != currentUser.getUserId()){ %>   
        <div class="col-md-4">
          <aside class="aa-properties-sidebar">
            <!-- Start Single properties sidebar -->
            <div class="aa-properties-single-sidebar">
              <h3>Detalii proprietar</h3>                                                                                    
            </div> 
            <p>Nume: <%=adImmobile.getOwnerFName() + " " + adImmobile.getOwnerLName() %></p>
         </aside>
       </div> 
       <%} %>  
      </div>
    </div>
  </section>
  <!-- / Properties  -->

  <!-- Footer -->
  <footer id="aa-footer">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
        <div class="aa-footer-area">
          <div class="row">           
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="aa-footer-middle">
                <a href="#"><i class="fa fa-facebook"></i></a>
                <a href="#"><i class="fa fa-twitter"></i></a>
                <a href="#"><i class="fa fa-google-plus"></i></a>
                <a href="#"><i class="fa fa-youtube"></i></a>
              </div>
            </div>           
          </div>
        </div>
      </div>
      </div>
    </div>
  </footer>
  <!-- / Footer -->
  <!-- jQuery library -->
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
  <script src="js/jquery.min.js"></script>   
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="js/bootstrap.js"></script>   
  <!-- slick slider -->
  <script type="text/javascript" src="js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="js/nouislider.js"></script>
   <!-- mixit slider -->
  <script type="text/javascript" src="js/jquery.mixitup.js"></script>
  <!-- Add fancyBox -->        
  <script type="text/javascript" src="js/jquery.fancybox.pack.js"></script>
  <!-- Custom js -->
  <script src="js/custom.js"></script> 
  
  </body>
</html>
<%}
else{
	response.sendRedirect("404.jsp");
	}
%>