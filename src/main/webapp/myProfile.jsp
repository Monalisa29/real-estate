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
String updateMessage = request.getParameter("mess");

if(Objects.isNull(userAccount)){
	response.sendRedirect("404.jsp");
}
else{
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Profilul meu</title>

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
    	.spacer{
        	margin-bottom: 6px; 
    	}
    </style>
    <script>
    function toggleSection(icon){
    	var section = document.getElementById("changePasswordBlock");
    	var oldPassword = document.getElementById("oldPassword");
    	var newPassword = document.getElementById("newPassword")
    	
    	if (section.style.display === "none") {
    		section.style.display = "block";
		    icon.src = "img/icons/down-arrow.png";
		 }
		 else{
			 section.style.display = "none"
			 icon.src = "img/icons/next.png";	
			 
			 oldPassword.value = "";
			 newPassword.value = "";
		 }
    }
    
    function validateForm(){
    	var phoneNr = document.getElementById('phoneNr').value;
    	var oldPassword = document.getElementById('oldPassword').value;
    	var newPassword = document.getElementById('newPassword').value;
    	var section = document.getElementById("changePasswordBlock");
    	
    	if(phoneNr == ""){
 		   alert("Campul 'Numar telefon' nu este completat!");
 		   return false;
 	   }
    	else if(isNaN(phoneNr) == true || Math.sign(phoneNr) === -1 || phoneNr.indexOf(".") != -1 || phoneNr.indexOf(",") != -1){
 		   alert("Numarul de telefon nu este completat corespunzator");
 		   return false;
 	   }
    	else if(section.style.display === "block"){
    		if(oldPassword != "" && newPassword == ""){
    	 	   alert("Campul 'Parola noua' nu este completat!");
    	 	   return false;
    	 	}    		
    		else if(oldPassword == "" && newPassword != ""){
    	 	   alert("Campul 'Parola veche' nu este completat!");
    	 	   return false;
    	 	} 
    		else if(newPassword.length < 4){
    		   alert("Parola trebuie sa aiba cel putin 4 caractere!");
     	 	   return false;
    		}
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
            <h2>Profilul meu</h2>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->
  
  <!-- Profile -->
  <section id="aa-properties">
  <div class="container">
  <div class="aa-properties-content">
  <form name="modifyForm" id="modifyForm" action="updateProfile.jsp" method="POST"> 
  <aside class="aa-properties-sidebar">  
    <div class="container">     
        <h4 style="color:#59abe3; padding-left: 90px;"><b>Date profil</b></h4>
        <%if(!Objects.isNull(updateMessage) && updateMessage.equals("0")){ %> <span style="color:red;">Datele profilului nu au putut fi modificate. Va rugam incercati mai tarziu.</span> <%} %>
        <%if(!Objects.isNull(updateMessage) && updateMessage.equals("1")){ %> <span style="color:green;">Datele profilului au fost modificate cu succes!</span> <%} %>
	    <%if(!Objects.isNull(updateMessage) && updateMessage.equals("2")){ %> <span style="color:red;">Numarul de telefon nu a putut fi modificat deoarece nu era valid</span> <%} %>
	    <%if(!Objects.isNull(updateMessage) && updateMessage.equals("3")){ %> <span style="color:red;">Parola veche este incorecta!</span> <%} %>
	    <br>
	    <%if(userAccount.getUserSex() == 'M'){ %><img alt="img" src="img/profile/man-profile.jpg"><%} %>
	    <%if(userAccount.getUserSex() == 'F'){ %><img alt="img" src="img/profile/woman-profile.jpg"><%} %><br><br>
	    <b><span>Nume: </span></b><span><%=userAccount.getUserLName() + " " + userAccount.getUserFName()%></span><br>     
        <b><span>Sex: </span></b><span>
        <%if(userAccount.getUserSex() == 'M'){ %><span>Masculin</span><%} %>
	    <%if(userAccount.getUserSex() == 'F'){ %><span>Feminin</span><%} %><br>     
	    <b><span>CNP: </span></b><span><%=userAccount.getUserCNP()%></span><br>       
	    <b><span>Email: </span></b><span><%=userAccount.getEmail()%></span><br>      
	    <div class="spacer"></div> 
	    <b><span>Numar telefon: </span></b><br>
	    <input style="width:200px;" type="text" id="phoneNr" name="phoneNr" value="<%=userAccount.getUserPhoneNr()%>"><br>     
	    <div class="spacer"></div>              
        <span><b><img class="arrow" id="newPasswordSection" src="img/icons/next.png" alt="arrow-down" onclick="toggleSection(this)"/>Modifica parola:</b></span>
        <div id="changePasswordBlock" style="display:none">
  			<b><span>Parola veche: </span></b><br>
	    	<input style="width:200px;" type="password" id="oldPassword" name="oldPassword"><br>  
	    	<b><span>Parola noua: </span></b><br>
	    	<input style="width:200px;" type="password" id="newPassword" name="newPassword"><br>    
        </div>
        <div class="spacer"></div><br>
        <div class="aa-single-advance-search">
          <input class="aa-search-btn submitButton" type="button" onclick="validateForm()" value="Modifica date profil">
        </div>
	 </div>  
  </aside>
  </form>
  </div> 
  </div>
  </section> 
    <!-- End rofile -->   
  
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