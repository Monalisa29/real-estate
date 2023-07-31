<%@page import="bean.UserAccount"%>
<%@page import="java.util.Objects"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%
String immobileId = request.getParameter("id");
session.setAttribute("immobileId", immobileId);
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");

ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
AdImmobile adImmobile = new AdImmobile();

if(!Objects.isNull(immobileId) && !Objects.isNull(userAccount)){
	adImmobile = immobileDBHelper.getImmobileById(Integer.parseInt(immobileId));
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Posteaza anunt</title>
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
    	.submitButton{
		  background-color:#59abe3; 
		  color:#fff; 
		  padding:5px 10px; 
		  border:none
		}
    </style>
  <script>  
  function validateForm(){
	  var title = document.getElementById("title").value;
	  var price = document.getElementById("price").value;
	  var category = document.getElementById("category").value;
	  var type = document.getElementById("type").value;
	  var postingPeriodsRB = document.getElementsByName("postingPeriod");
	  var selectedPeriod = "";
	  for (i = 0; i < postingPeriodsRB.length; i++) {
          if (postingPeriodsRB[i].checked)
           {
        	  selectedPeriod = postingPeriodsRB[i].value;
           }
      }
	  
	  if(title == ""){
		   alert("Campul 'Titlu' este obligatoriu!");
		   return false;
	   }
	  else if(title.length <= 10){
		  alert("Campul 'Titlu' trebuie sa aiba cel putin 10 caractere!");
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
	  else if(category == ""){
		   alert("Campul 'Categorie' este obligatoriu!");
		   return false;
	   }
	  else if(type == ""){
		   alert("Campul 'Tip' este obligatoriu!");
		   return false;
	   }
	  else if(selectedPeriod == ""){
		   alert("Trebuie sa selectati perioada de postare a anuntului!");
		   return false;
	   }
	  document.newAdForm.submit();
  }
  
  function setTypeByCategory()
  {
	  var category = document.getElementById("category").value;
	  var type = document.getElementById("type");
	   
	  var optionType = new Option("", "");
	  var optionTypeRent = new Option("Inchiriere", "Inchiriere");
	  var optionTypeSale = new Option("Vanzare", "Vanzare");
	   
	   if(category == "Teren"){
		   type.options.length = 0;
		   type.add(optionType);
		   type.add(optionTypeSale);
	   }	
	   else{
		   type.options.length = 0;
		   type.add(optionType);
		   type.add(optionTypeRent);
		   type.add(optionTypeSale);
	   }
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
              <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="aa-header-right">
                  <a href="register.jsp" class="aa-register">Inregistreaza-te</a>
                  <a href="signin.jsp" class="aa-login">Conecteaza-te</a>
                </div>
              </div>
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
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="">CONTUL MEU <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">    
                <li><a href="myProfile.jsp">PROFILUL MEU</a></li>              
                <li><a href="myRealEstates.jsp">IMOBILELE MELE</a></li>
                <li><a href="myAds.jsp">ANUNTURILE MELE</a></li>      
                <li><a href="">FAVORITE</a></li>  
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
            <h2>POSTEAZA UN ANUNT</h2>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->
  
 <section id="aa-properties">
   <div class="container">
    <div class="aa-properties-content">
     <aside class="aa-properties-sidebar">
      <div class="container">
      <form name="newAdForm" id="newAdForm" action="insertAd.jsp" method="GET">
      <label for="usableArea"><b>Suprafata utila: </b><%=adImmobile.getUsableArea() %> (mp)</label><br>
	    <label for="description"><b>Descriere: </b><%=adImmobile.getDescImmobile() %></label><br>
	     <%if(adImmobile.getYearImmobile() != 0){ %>
	    <label for="year"><b>An constructie: </b><%=adImmobile.getYearImmobile() %></label><br>
	    <%} %>
	     <%if(adImmobile.getRoomsNrImmobile() != 0){ %>
	    <label for="roomsNr"><b>Numar de camere: </b><%=adImmobile.getRoomsNrImmobile()%></label><br>     
	    <%} %>  
        <label for="county"><b>Judet: </b><%=adImmobile.getCounty()%></label><br>    
	    <label for="city"><b>Oras: </b><%=adImmobile.getCity() %></label><br>   	      
	    <label for="streetName"><b>Strada: </b><%=adImmobile.getStreedName() %></label><br>
        <label for="adressNr"><b>Numar: </b><%=adImmobile.getAddressNr()%></label><br>
        <label for="picture"><b>Poza: </b><br><img src="img/immobileImages/<%=adImmobile.getPicture() %>" alt="img" width="340" height="240"></label><br>      
        <label for="title"><b>Titlu</b></label><br>
        <textarea id="title" name="title" rows="2" cols="20" maxlength="40"></textarea><br>
        <label for="category"><b>Categorie</b></label><br>
        <div class="aa-single-advance-search">
           <%if(adImmobile.getRoomsNrImmobile() != 0){ %>
	       <select style="width:230px;" name="category" id="category" onchange="setTypeByCategory()">
	         <option value="" selected></option>
	         <option value="ApartamentGarsoniera">Apartament-Garsoniera</option>
	         <option value="Casa">Casa</option>
	         <option value="Teren">Teren</option>
	       </select>
	       <%}else{ %>
	       <select style="width:230px;" name="category" id="category" onchange="setTypeByCategory()">
	         <option value="" selected></option>
	         <option value="Teren">Teren</option>
	       </select>
	       <%} %>
	    </div>
	    <label for="type"><b>Tip</b></label><br>
	    <div class="aa-single-advance-search">
	       <select style="width:230px;" name="type" id="type">
	         <option value="" selected></option>
	         <option value="Vanzare">Vanzare</option>
	         <option value="Inchiriere">Inchiriere</option>
	       </select>
	    </div>	    
	    <label for="price"><b>Pret (lei)</b></label><br>
        <input type="text" id="price" name="price"><br>
        <label><b>Perioada de postare a anuntului</b></label><br>
        <input type="radio" name="postingPeriod" value="1">1 luna<br>
		<input type="radio" name="postingPeriod" value="2">2 luni<br>
		<input type="radio" name="postingPeriod" value="3">3 luni<br>
		<input type="radio" name="postingPeriod" value="6">6 luni<br><br>
        <div class="aa-single-advance-search">
          <input class="aa-search-btn submitButton" type="button" onclick="validateForm()" value="Adauga anunt">
        </div>
        </form>
       </div>
      </aside>
    </div>
   </div>
  </section>
  
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
<%}else{
	response.sendRedirect("404.jsp");
}
%>