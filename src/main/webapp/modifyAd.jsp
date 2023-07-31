<%@page import="DAO.AdDBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Objects"%>
<%@page import="helper.ImmobileHelper"%>
<%@page import="bean.AdImmobile"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="bean.UserAccount"%>
<%@ page import = "java.util.List" %>
<%@page import="java.util.ArrayList"%>

<%
String sqlException = null;
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
String adId = request.getParameter("id");;
String adCategory = request.getParameter("cat");
String errorMessage = request.getParameter("err");;

if(Objects.isNull(userAccount)){
	response.sendRedirect("404.jsp");
}
else{
	AdDBHelper adDBHelper = new AdDBHelper();
	AdImmobile adImmobile = adDBHelper.getAdImmobileById(Integer.parseInt(adId), Integer.parseInt(adCategory));
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Modifica anunt</title>

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
    <script>
    function validateForm(){
  	  var title = document.getElementById("title").value;
  	  var price = document.getElementById("price").value; 	  
  	  var description = document.getElementById('description').value; 	  
  	  
  	  if(title == ""){
  		   alert("Campul 'Titlu' este obligatoriu!");
  		   return false;
  	   }
  	  else if(title.length <= 10){
  		  alert("Campul 'Titlu' trebuie sa aiba cel putin 10 caractere!");
  		   return false;
  	  }
  	  else if(description == ""){
		   alert("Campul 'Descriere' este obligatoriu!");
		   return false;
	   }  
  	  else if(price == ""){
  		   alert("Campul 'Pret' este obligatoriu!");
  		   return false;
  	   }
  	  else if(isNaN(price) == true || Math.sign(price) === -1 || price.indexOf(".") != -1 || price.indexOf(",") != -1){
  		   alert("Pretul trebuie sa fie un numar mai mare decat 0");
  		   return false;
  	   }	  
  	  document.modifyForm.submit();
    }
    </script>
  </head>
<body>
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
            <h2>Modifica anunt</h2>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->
  
  <!-- Post ad -->
  <section id="aa-properties">
  <div class="container">
  <div class="aa-properties-content">
  <form name="modifyForm" id="modifyForm" action="updateAd.jsp" method="POST"> 
  <aside class="aa-properties-sidebar">  
    <!-- Add new immobile -->
    <div class="container">
      <span style="color:#59abe3; font-weight:bold; font-size:24px;">Detalii anunt</span>
       <div id="optionNewImBlock"><br>
        <%if(!Objects.isNull(errorMessage) && errorMessage.equals("1")){ %>
          <span style="color:red;">Anuntul nu a putut fi modificat! </span><br>
        <%} %>
	    <b><span>Suprafata utila: </span></b><span><%=adImmobile.getUsableArea()%> (mp)</span><br>     
	    <b><span>Adresa: </span></b><span><%=adImmobile.getCounty()%> - <%=adImmobile.getCity()%>, str. <%=adImmobile.getStreedName()%> nr. <%=adImmobile.getAddressNr()%></span><br>	    
	    <b><span>Categorie: </span></b><span><%=adImmobile.getCategoryName()%></span><br>
        <b><span>Tip: </span></b><span><%=adImmobile.getImmobileType()%></span><br>
         <%if(adImmobile.getYearImmobile() != 0){ %>
	    <b><span>An constructie: </span></b><span><%=adImmobile.getYearImmobile()%></span><br>
	    <%} %>
	     <%if(adImmobile.getCategoryId() == 1 || adImmobile.getCategoryId() == 2){ %>
	    <b><span>Numar de camere: </span></b><span><%=adImmobile.getRoomsNrImmobile()%></span><br>
	    <b><span>Etaj: </span></b><span><%=adImmobile.getFloorAp()%></span><br>
        <b><span>Compartimentare: </span></b><span><%=adImmobile.getPartitioningAp()%></span><br>	           
        <%} %>
        <%if(adImmobile.getCategoryId() == 3 || adImmobile.getCategoryId() == 4){ %>
         <b><span>Numar de etaje: </span></b><span><%=adImmobile.getFloorsNrHouse()%></span><br>
        <%} %>
        <%if(adImmobile.getAdStatus().equals("activ")){ %>
        <b><span>Data de expirare a anuntului: </span></b><span></span><br>
        <%} %>
        <b><span>Titlu: </span></b><br>
        <input style="width:200px;" type="text" id="title" name="title" value="<%=adImmobile.getAdTitle()%>"><br>
        <b><span>Descriere: </span></b><br>
	    <textarea id="description" name="description" rows="4" cols="50"><%=adImmobile.getDescImmobile()%></textarea><br>
	    <b><span>Pret (lei): </span></b><br>
        <input style="width:200px;" type="text" id="price" name="price" value="<%=adImmobile.getPriceImmobile()%>"><br>
        <b><span>Status anunt: </span></b><br>
	        <div class="aa-single-advance-search">
		       <select style="width:230px" name="status" id="status">
		         <option value="<%=adImmobile.getAdStatus()%>" selected><%=adImmobile.getAdStatus()%></option>
		         <option value="inactiv">inactiv</option>
		       </select>
		    </div>
	    <b><span>Poza: </span></b><br>
        <img alt="img" src="img/immobileImages/<%=adImmobile.getPicture() %>" width="500" height="300"><br><br>
        <input type="hidden" id="hiddenId" name="hiddenId" value="<%=adImmobile.getAdId()%>"> 
        <input type="hidden" id="hiddenCategory" name="hiddenCategory" value="<%=adImmobile.getCategoryId()%>"> 
        <div class="aa-single-advance-search">
          <input class="aa-search-btn submitButton" type="button" onclick="validateForm()" value="Modifica anunt">
        </div>
      </div>
	 </div>
    <!-- End new immobile -->     
  </aside>
  </form>
  </div> 
  </div>
  </section> 
  <!-- End Post ad -->
  
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
  <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
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
<%} %>