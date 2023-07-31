<%@page import="java.util.Objects"%>
<%@page import="bean.UserAccount"%>
<%
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
String errorEmailSend = request.getParameter("send");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Contact</title>
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
       var email = document.getElementById('email').value;
       var password = document.getElementById('password').value;
  	   var subject = document.getElementById('subject').value;
  	   var comment = document.getElementById('comment').value;
  	   
  	   if(email == ""){
		   alert("Campul 'Email' este obligatoriu!");
		   return false;
		}
	   else if(!email.endsWith("@yahoo.com") && !email.endsWith("@gmail.com")){
			alert("Campul 'Email' trebuie sa fie de forma 'nume@x.com'");
			return false;
	   }
	   else if(password == ""){
		   alert("Campul 'Parola' este obligatoriu!");
		   return false;
		}
	   else if(subject == ""){
		   alert("Campul 'Subiect' este obligatoriu!");
		   return false;
		}
	   else if(comment == ""){
		   alert("Campul 'Descriere' este obligatoriu!");
		   return false;
		}
  	 document.forms['contactEmailform'].submit();
    }
    </script>
    <style>
    .comment-form-password input[type="password"]{
	    border: none;
	    border-bottom: 2px solid #ccc;
	    color: #555;
	    margin-bottom: 10px;
	    height: 35px;
	    padding: 5px;
	    width: 100%;
    }
    </style>
  </head>
  <body>
  
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
             <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="">ANUNTURI <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">                
                <li><a href="searchImmobile.jsp">CAUTA ANUNTURI</a></li>
                <li><a href="addImmobile.jsp">POSTEAZA ANUNT</a></li>                                            
              </ul>
            </li>
            <li><a href="gallery.jsp">GALERIE</a></li>                                         
            <li><a href="tipsPage.jsp">SFATURI </a></li>
            <li class="active"><a href="contact.jsp">CONTACT</a></li>
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
            <h2>Contact</h2>
            <ol class="breadcrumb">
            <li><a href="#">Acasa</a></li>            
            <li class="active">Contact</li>
          </ol>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->

 <section id="aa-contact">
   <div class="container">
     <div class="row">
       <div class="col-md-12">
          <div class="aa-contact-area">
            <div class="aa-contact-top">
              <div class="aa-contact-top-left">
                <iframe width="100%" height="450" frameborder="0" allowfullscreen="" style="border:0" src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2799.305831073219!2d28.0490638!3d45.4434929!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x40b6de501138ff0f%3A0x5105bbdf006bddc2!2sFacultatea%20de%20Economie%20si%20Administrarea%20Afacerilor!5e0!3m2!1sro!2sro!4v1684397900227!5m2!1sro!2sro"></iframe>
              </div>
              <div class="aa-contact-top-right">
                <h2>Contact</h2>
                <p>Bine ati venit la agentia noastra imobiliara! Suntem aici sa va ajutam in gasirea locuintei perfecte. Completati formularul de contact de mai jos sau vizitati-ne la adresa noastra pentru a discuta despre nevoile dvs. imobile.</p>
                <ul class="contact-info-list">
                  <li> <i class="fa fa-phone"></i> 1-900-523-3564</li>
                  <li> <i class="fa fa-envelope-o"></i> homestor@gmail.com</li>
                  <li> <i class="fa fa-map-marker"></i> Strada Garii, Galati 800008</li>
                </ul>
              </div>
            </div>
            <div class="aa-contact-bottom">
              <div class="aa-title">
                <h2>Trimite-ne un mesaj</h2>
                <span></span>
              </div>             
              <div class="aa-contact-form">
                <form class="contactform"  name="contactEmailform" id="contactEmailform" action="sendEmail.jsp" method="POST">  
                <span style="color:green;"><%if(!Objects.isNull(errorEmailSend) && errorEmailSend.equals("1")){ %> Mesajul dvs. a fost trimis cu succes. <%} %></span>
                <span style="color:red;"><%if(!Objects.isNull(errorEmailSend) && errorEmailSend.equals("0")){ %> Mesajul dvs. nu a putut fi trimis, va rugam incercati mai tarziu. <%} %></span><br><br>                              
                  <p class="comment-form-email">
                    <label for="email">Email <span class="required">*</span></label>
                    <input type="email" name="email" id="email">
                  </p>
                  <p class="comment-form-password">
	                <label for="password">Parola <span class="required">*</span></label>
	                <input type="password" name="password" id="password"> 
                  </p>
                  <p class="comment-form-url">
                    <label for="subject">Subiect <span class="required">*</span></label>
                    <input type="text" name="subject" id="subject">  
                  </p>
                  <p class="comment-form-comment">
                    <label for="comment">Descriere <span class="required">*</span></label>
                    <textarea name="comment" id="comment" cols="45" rows="8"></textarea>
                  </p>                
                  <p class="form-submit">
                    <input type="button" class="aa-browse-btn" onclick="validateForm()" value="Trimite mesaj">
                  </p>        
                </form>
              </div>
            </div>
          </div>
       </div>
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