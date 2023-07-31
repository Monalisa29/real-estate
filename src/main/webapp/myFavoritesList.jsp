<%@page import="DAO.FavoriteAdsDBHelper"%>
<%@page import="java.util.List"%>
<%@page import="bean.UserAccount"%>
<%@page import="java.sql.SQLException"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="java.util.Objects"%>
<%@page import="DAO.AdDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
FavoriteAdsDBHelper favoriteAdsDBHelper = new FavoriteAdsDBHelper();
List<AdImmobile> adImmobiles = favoriteAdsDBHelper.getFavoriteAdsByUser(userAccount.getUserId());
String selectedCategory = request.getParameter("adStatus");
int adsNr = 0;
if(Objects.isNull(selectedCategory)){
	selectedCategory = "Toate";
}
if(Objects.isNull(userAccount)){
	response.sendRedirect("404.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Lista de favorite</title>
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
	.aa-properties-item-img {
	  position: relative;
	}
	
	.aa-properties-item-img img {
	  max-width: 100% !important;
	  height: auto !important;
	}
    .favorite-icon {
	  position: absolute;
	  top: 10px;
	  left: 700px;
	  width: 10px;
	  height: 10px;
	}
	.favorite-details {
	  position: absolute;
	  top: 0;
	  left: 10;
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
    </style>
    <script>
	    jQuery(document).ready(function() {
		    jQuery("#aa-list-properties").addClass("active");
		    jQuery(".aa-properties-nav").addClass("aa-list-view");
	   });
	    
	    function deleteFromFavorites(adId){
	    	var answer = confirm("Sunteti sigur ca doriti sa stergeti acest anunt din lista?");
	        if (answer) {
	        	window.location.href = "insertDeleteFavotite.jsp?adId="+adId+"&from=fav";
	        	event.preventDefault(); 
	        } 
	        else {
	            event.preventDefault(); 
	        }
	    }
	    
	    function showAdsByStatus()
	    {
	       var status = document.getElementById("adStatus").value;
	 	   if(status != null){	  	   	   
	 		 document.getElementById("adsForm").submit();	 
	 	   }
	    }
    </script>
  </head>
  <body class="aa-price-range">  
  <!-- Pre Loader -->
  <div id="aa-preloader-area">
    <div class="pulse"></div>
  </div>
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
              <%if(Objects.isNull(userAccount)){ %>
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
             <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="">ANUNTURI <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">                
                <li><a href="searchImmobile.jsp">CAUTA ANUNTURI</a></li>
                <li><a href="addImmobile.jsp">POSTEAZA ANUNT</a></li>                                            
              </ul>
            </li>
            <li><a href="">GALERIE</a></li>                                         
            <li><a href="tipsPage.jsp">SFATURI </a></li>
            <li><a href="contact.jsp">CONTACT</a></li>
           <li class="dropdown active">
              <a class="dropdown-toggle" data-toggle="dropdown" href="">CONTUL MEU <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">                
                <li><a href="myProfile.jsp">PROFILUL MEU</a></li>  
                <li><a href="myRealEstates.jsp">IMOBILELE MELE</a></li>
                <li><a href="myAds.jsp">ANUNTURILE MELE</a></li>      
                <li><a href="myFavoritesList.jsp">LISTA DE FAVORITE</a></li>  
                <li><a href="logout.jsp">DECONECTEAZA-TE</a></li>                                        
              </ul>
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
            <h2>Lista de favorite</h2>
            <ol class="breadcrumb">
            <li><a href="#">Contul meu</a></li>            
            <li class="active">Lista de favorite</li>
            </ol>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->
  
   <!-- Start Properties  -->
  <form name="adsForm" id="adsForm" action="" method="post">
  <section id="aa-properties">
    <div class="container">   
     <div class="row">
      <div class="col-md-8">
      <div class="aa-properties-content">	
        <!-- start properties content head -->          
        <%if(adImmobiles.isEmpty()){ %>
        <aside class="aa-properties-sidebar">
          <div class="aa-properties-single-sidebar">
           	 <h2 style="font-size:25px;font-weight:600;margin-top:240px;margin-bottom:320px;margin-left:20px;">Nu ati salvat inca niciun anunt.</h2>
		  </div>
	    </aside>
	     <%} 
		  else{%>				  				                     		  
            <!-- Start properties content body -->
            <div class="aa-properties-content-body"> 
            <form name="adsForm" id="adsForm" action="insertDeleteFavotite.jsp" method="post">
            <div class="aa-properties-content-head">                                       
                <div class="aa-single-advance-search">
                 <span style="color:#59abe3;font-weight:bold;">Status anunturi:</span>
                  <select style="width:220px;" name="adStatus" id="adStatus" onchange="showAdsByStatus()">
                    <option value="Toate" <%if(selectedCategory.equals("ApartamentGarsoniera")){ %> selected <%} %>>Toate</option>
                    <option value="ApartamentGarsoniera" <%if(selectedCategory.equals("ApartamentGarsoniera")){ %> selected <%} %>>Apartamente si garsoniere</option>
                    <option value="Casa" <%if(selectedCategory.equals("Casa")){ %> selected <%} %>>Case</option>
                    <option value="Teren" <%if(selectedCategory.equals("Teren")){ %> selected <%} %>>Terenuri</option>
                  </select>
                </div>
              </div>   
             </form>                   
              <ul class="aa-properties-nav">             
              <%for(AdImmobile ad : adImmobiles){ %>
              <%if(ad.getCategoryName().equals(selectedCategory) || selectedCategory.equals("Toate")){ 
                 adsNr++;%>
                <li>                 
                  <article class="aa-properties-item">
                    <a class="aa-properties-item-img" href="">
                      <img src="img/immobileImages/<%=ad.getPicture() %>" alt="img" width="340" height="240">
                      <div class="favorite-details">
                       <img src="img/icons/favorite-red.png" alt="img" class="favorite-icon" onclick="deleteFromFavorites(<%=ad.getAdId()%>)">
                      </div>
                    </a>
                    <%if("Inchiriere".equals(ad.getImmobileType())){ %><div class="aa-tag for-rent"><%}else{ %><div class="aa-tag for-sale"><%} %>
                      <%=ad.getImmobileType() %>
                    </div>
                    <div class="aa-properties-item-content">
                      <div class="aa-properties-info">
                      <%if(ad.getRoomsNrImmobile() != 0){ %>
                        <span><%=ad.getRoomsNrImmobile()%> camere</span>
                        <%} %>
                        <span><%=ad.getUsableArea()%> mp</span>
                        <span><%=ad.getCategoryName() %></span>
                      </div>
                      <div class="aa-properties-about">
                        <h3><a href="#"><%=ad.getAdTitle()%></a></h3>
                        <%if(ad.getDescImmobile().length() <= 80){%><p><%=ad.getDescImmobile()%></p><% }else{%><p><%=ad.getDescImmobile().substring(0, 80) + "..."%></p><%}%>                    
                      </div>
                      <div class="aa-properties-detial">
                        <span class="aa-price">
                          <%=ad.getPriceImmobile()%> LEI
                        </span>
                        <a class="aa-secondary-btn" href="properties_detail.jsp?id=<%=ad.getAdId() %>&cat=<%=ad.getCategoryId() %>" target="_blank">Detalii</a>
                      </div>
                    </div>
                  </article>
                </li>  
                <%  } %>    
                <% } %>                                               
              </ul>   
               <%if(adsNr == 0){ %>
		        <aside class="aa-properties-sidebar">
		          <div class="aa-properties-single-sidebar">
		           	 <h2 style="font-size:25px;font-weight:600;margin-top:240px;margin-bottom:320px;margin-left:20px;">Nu aveti anunturi cu acest status.</h2>
				  </div>
			    </aside>
			   <%}%>         
            </div>
            <%} %>
         </div>
        </div>   
       </div>         
      </div>
  </section>
  </form>
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