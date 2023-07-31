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
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
List<AdImmobile> adImmobiles = immobileDBHelper.getImmobileListByUserId(userAccount.getUserId());
if(Objects.isNull(userAccount)){
	response.sendRedirect("404.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Imobilele mele</title>
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
    .tableHeader {	 
	  font-size: 19px; 
	  color: #333; 
	}
	.detailsTable {
	  border-collapse: collapse;
	  width: 75%;
	}
	.detailsTable td,th{
      padding: 15px;
  	  text-align: center;
      border-bottom: 2px solid #ddd;
	}
	.link-row {
	  text-decoration: none; 
	}
	.link-row:hover {
	  background-color: #59abe3; 
	  cursor: pointer; 
	}
	.link-row:hover td {
	  color: #FFFFFF; 
	}	
	.noAdsMess{
  		font-size:25px;
  		font-weight:600;
  		margin-top:240px;
  		margin-bottom:320px;
  		margin-left:20px;
  	}
  	.tableRealEstate{
  		margin-top:30px;
  		margin-bottom:80px;
  	    display: flex;
  	    justify-content: center;
  	}
 </style>  
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
            <li><a href="gallery.jsp">GALERIE</a></li>                                         
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
            <h2>Imobilele mele</h2>
            <ol class="breadcrumb">
            <li><a href="#">Contul meu</a></li>            
            <li class="active">Imobilele mele</li>
            </ol>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->
  
  <!-- Real Estates -->
  <section id="aa-properties">
  <div class="container">
  <div class="aa-properties-content">	
   <aside class="aa-properties-sidebar">
    <%if(!adImmobiles.isEmpty()){ %>
	<div class="tableRealEstate">   		    
      	<table class="detailsTable">
      	  <tr class="tableHeader">
		    <th>Suprafata utila (mp)</th>
		    <th>Judet</th>
		    <th>Oras</th>
		    <th>Strada</th>
		    <th>Numar</th>		    
		  </tr>
		  <%for(AdImmobile immobile : adImmobiles) {%>
		  <tr class="link-row" onclick="window.open('immobileDetails.jsp?id=<%=immobile.getImmobileId()%>', '_blank')">
		    <td><%=immobile.getUsableArea() %></td>
		    <td><%=immobile.getCounty() %></td>
		    <td><%=immobile.getCity() %></td>
		    <td><%=immobile.getStreedName() %></td>
		    <td><%=immobile.getAddressNr()%></td>
		  </tr>
		  <%} %>
      	</table><br>      	  	
    </div>
    <%}else{ %>
      <aside class="aa-properties-sidebar">
       <div class="aa-properties-single-sidebar">
         <h2 class="noAdsMess">Nu ati inregistrat inca niciun imobil.</h2>
	   </div>
	 </aside>
    <%} %>
   </aside>
  </div>
  </div>
  </section>
  <!-- End Real Estates -->

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