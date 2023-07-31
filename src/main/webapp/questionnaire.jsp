<%@page import="java.util.List"%>
<%@page import="bean.Questionnaire"%>
<%@page import="DAO.QuestionnaireDBHelper"%>
<%@page import="bean.UserAccount"%>
<%@page import="java.util.Objects"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
if(Objects.isNull(currentUser)){
	response.sendRedirect("404.jsp");
}
QuestionnaireDBHelper questionnaireDBHelper = new QuestionnaireDBHelper();
List<Questionnaire> questions = questionnaireDBHelper.getQuestions();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Chestionar</title>
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
    function validateForm(listLength){    	
      for (var i = 1; i <= listLength; i++) {
    	var className = 'question' + i;
    	var questionRB = document.getElementsByName(className);
    	   
    	var selectedAnswer = "";
        for (var j = 0; j < questionRB.length; j++) {
    	   if (questionRB[j].checked)
	       {
	          selectedAnswer = questionRB[j].value;
	          break;
	       }
    	}
    		  
   		if(selectedAnswer == ""){
   		  alert("Toate intrebarile sunt obligatorii!");
 		  return false;
   		}
      } 	
      document.questionnaireForm.submit();
  }
    
   function showReasonArea() {
   	  var question5Area = document.getElementById("question5Area");
   	  var question10Area = document.getElementById("question10Area"); 
   	  var question5RB = document.querySelector('input[name="question5"]:checked');
   	  var question10RB = document.querySelector('input[name="question10"]:checked');
   	  
   	  if (question5RB.value === "Altele (va rugam sa specificati)") {
   		question5Area.style.display = "block";
   	  } else {
   		question5Area.style.display = "none";
   	  }
   	  
   	if (question10RB.value === "Nu (va rugam sa specificati motivul)") {
   		question10Area.style.display = "block";
   	  } else {
   		question10Area.style.display = "none";
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
            <h2>Chestionar</h2>
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
      <div class="aa-properties-single-sidebar">
         <h3 style="color:#59abe3;"><b>Impartaseste-ti experientele</b></h3> 
         <p>Spuneti parerea si observatiile legate de vanzarea/inchirierea de imobile. Vrem sa aflam parerile tale pentru a putea imbunatati aceste experiente.</p>
       </div>
      <form name="questionnaireForm" id="questionnaireForm" action="insertAnswersQuestions.jsp" method="GET">
      <%for(Questionnaire question : questions){ %>
        <br><label><%=question.getQuestionText() %></label><br>
         <%for(String option : question.getAnswerOptions()){ %>
          <input type="radio" name="question<%=question.getQuestionId() %>" value="<%=option%>" onclick="showReasonArea()"><%=option %><br>
         <%} %>
         <%if(question.getQuestionId() == 5){ %>
          <textarea id="question5Area" name="question5Area" rows="2" cols="20" maxlength="40" style="display: none;"></textarea><br>
         <%} %>
         <%if(question.getQuestionId() == 10){ %>
          <textarea id="question10Area" name="question10Area" rows="2" cols="20" maxlength="40" style="display: none;"></textarea><br>
         <%} %>
      <%} %>
        <br><div class="aa-single-advance-search">
          <input class="aa-search-btn submitButton" type="button" onclick="validateForm(<%=questions.size() %>)" value="Trimiteti chestionar">
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