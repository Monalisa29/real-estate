<%@page import="java.sql.SQLException"%>
<%@page import="DAO.CommentDBHelper"%>
<%@page import="java.util.List"%>
<%@page import="bean.Comment"%>
<%@page import="bean.UserAccount"%>
<%
String messInsert = request.getParameter("mess");
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
CommentDBHelper commentDBHelper = new CommentDBHelper();
List<Comment> comments = null;
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
boolean ableToComment = false;

if(Objects.isNull(userAccount)){
	session.setAttribute("signinFromPage", "tips");
	response.sendRedirect("signin.jsp");
}
else{
	try{
		comments = commentDBHelper.getAllComments();
		ableToComment = commentDBHelper.isUserAbleToComment(userAccount.getUserId());
	}
	catch(SQLException e){
		response.sendRedirect("404.jsp");
	}
%>
<!DOCTYPE html>
<%@page import="java.util.Objects"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Sfaturi</title>
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
    	.noCommMessage{
    		font-size:25px;
    		color: #59abe3;
    	}
    </style>
    <script>
    	function validateForm(){
    		var commentText = document.getElementById("commentText").value;
    		
	    	if(commentText == ""){
	 		   alert("Comentariul nu poate fi gol!");
	 		   return false;
	 	   }
	    	else if(commentText.length < 10){
	    		alert("Comentariul nu poate fi atat de scurt!");
		 		return false;
	    	}
	    	
	    	document.commentForm.submit();
    	}
    </script>
  </head>
  <body> 
  <!-- Pre Loader -->
  <div id="aa-preloader-area">
    <div class="pulse"></div>
  </div>
  
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
            <li class="active"><a href="tipsPage.jsp">SFATURI </a></li>
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
            <h2>Sectiunea de sfaturi</h2>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->

  <!-- Start Blog  -->
  <section id="aa-blog">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-blog-area">
            <div class="row">
              <div class="col-md-8">
                <div class="aa-blog-content">
                  <div class="row">
                    <div class="col-md-12">
                      <article class="aa-blog-single aa-blog-details">
                        <figure class="aa-blog-img">
                          <a href="#"><img alt="img" src="img/advice.jpg"></a>
                        </figure>
                        <div class="aa-blog-single-content">
                          <h2>Sfaturi imobiliare</h2>
                          <p>Bine ati venit la sectiunea noastra de sfaturi imobiliare! Aici puteti gasi o gama variata de comentarii si sfaturi utile de la persoane care au trecut prin procesul de vanzare, cumparare sau inchiriere a unei proprietati.</p>
                          <p>Scopul acestei sectiuni este sa oferim o platforma interactiva in care utilizatorii nostri sa poata impartasi experientele lor si sa ofere sfaturi valoroase celor care se afla in cautarea unui nou camin sau core doresc sa isi vanda sau sa isi inchirieze proprietatea.</p>
                          <p>Va incurajam sa explorati aceasta sectiune si sa contribuiti cu propriile dvs. sfaturi si experiente.</p>
                          <p>Multumim ca faceti parte din comunitatea noastra!</p>
                          <blockquote>
                            <p>Experienta este cel mai bun profesor. Dar invatarea din experienta altora este unul dintre cele mai valoroase daruri pe care le putem primi in drumul nostru catre succesul imobiliar.</p>
                          </blockquote>
                        </div>                   
                      </article>
                    </div>
                    
                    <!-- Related blog post -->
                    <div class="col-md-12">
                      <div class="aa-blog-related-post">
                        <div class="aa-title">
                          <h2>Sfaturile noastre</h2>
                          <span></span>
                        </div>
                        <div class="aa-blog-related-post-area">
                          <div class="row">
                            <div class="col-md-6 col-sm-6">
                              <article class="aa-blog-single">                               
                                <div class="aa-blog-single-content">
                                  <h3><a href="#">Stabiliti-va buigetul</a></h3>
                                  <p>Analizati-va finantele si determinati suma pe care sunteti dispusi sa o alocati pentru achizitia sau chiria unei proprietati. Nu uitati sa luati in considerare si costurile suplimentare asociate cu achizitionarea unei locuinte.</p>                                
                                </div>                   
                              </article>
                            </div>
                            <div class="col-md-6 col-sm-6">
                              <article class="aa-blog-single">                               
                                <div class="aa-blog-single-content">
                                  <h3><a href="#">Prioritati si nevoi</a></h3>
                                  <p>Stabiliti cu atentie ce este cu adevarat important pentru dumneavoastra intr-o proprietate. Ganditi-va la caracteristici precum localizarea, dimensiunea, facilitatile din jur, accesul la transport public, scoli sau alte servicii.</p>                                 
                                </div>                   
                              </article>
                            </div>
                            <div class="col-md-6 col-sm-6">
                              <article class="aa-blog-single">                               
                                <div class="aa-blog-single-content">
                                  <h3><a href="#">Evaluarea proprietatii</a></h3>
                                  <p>Luati in considerare sa obtineti o evaluarea profesionala a proprietatii inainte de a o lista pe piata. Astfel, veti obtine o ideee clara despre valoarea reala a proprietatii dumneavoastra si veti putea seta un pret corect.</p>                                 
                                </div>                   
                              </article>
                            </div>
                            <div class="col-md-6 col-sm-6">
                              <article class="aa-blog-single">                               
                                <div class="aa-blog-single-content">
                                  <h3><a href="#">Curatenie si prezentare</a></h3>
                                  <p>Asigurati-va ca proprietatea este bine curatata si prezentata in mod atragator inainte de a primi potentiali cumparatori sau chiriasi. O prima impresie pozitiva poate juca un rol important in atragerea ofertelor.</p>                                  
                                </div>                   
                              </article>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>  
                    <!-- comment threats -->
                    <div class="col-md-12">
                      <div class="aa-comments-area">
                      <div class="aa-title">
                          <h2>Sfaturile voastre</h2>
                          <span></span>
                        </div>
                        <%if(!Objects.isNull(messInsert) && messInsert.equals("0")){ %> <h4 style="color:red">Comentariul dvs. nu a putut fi postat. Incercati mai tarziu.</h4> <%} %>
                        <%if(!Objects.isNull(messInsert) && messInsert.equals("1")){ %> <h4 style="color:green">Comentariul dvs. a fost postat cu succes.</h4> <%} %>
                        <h3><%=comments.size() %> <%if(comments.size() == 1){%> comentariu <%}else{ %> comentarii <%} %></h3>
                        <div class="comments">
                          <ul class="commentlist">
                            <li>                           
                              <div class="media">
                              <%if(!comments.isEmpty()){ %>                                
                                 <%for(Comment comment : comments){ %>      
                                 <div class="media-left">    
                                    <img alt="img" src="img/person_comment.png" class="media-object news-img">      
                                </div>                        
                                 <div class="media-body">
                                 <h4 class="author-name"><%=comment.getUserFName() + " " + comment.getUserLName()%></h4>
                                 <span class="comments-date"> <%=comment.getDateComment() %></span>
                                 <p><%=comment.getCommentText() %></p>
                                 </div><br>
                                 <%} %>
                                <%} else{%>
                                 <h3 class="noCommMessage">Inca nu nu sunt comentarii. Fii tu primul care lasa unul.</h3>
                                <%} %>
                              </div>
                            </li>                          
                          </ul>                        
                        </div>
                      </div>
                    </div>   
                    <!-- Respond box -->
                    <div class="col-md-12">
                      <div id="respond">
                       <%if(ableToComment){ %>
                        <h3 class="reply-title">Lasa un comentariu cu sfatul tau</h3>
                        <form name="commentForm" id="commentForm" action="insertComment.jsp" method="GET">                       
                          <p class="comment-form-comment">
                            <label for="commentText">Comentariu</label>
                            <textarea rows="8" cols="45" maxlength="600" id="commentText" name="commentText"></textarea>
                          </p>                         
                          <p class="form-submit">
                            <input type="button" onclick="validateForm()" value="Posteaza comentariu">
                          </p>        
                        </form>
                        <%}else{ %>
                         <h4>Pentru a putea lasa un comentariu trebuie sa fi participat cel putin o data la un proces de inchiriere/cumparare/vanzare prin intermediul agentiei noastre <span class="required">*</span></h4>
                        <%} %>
                      </div>
                    </div>
                  </div>                                   
                </div>
              </div>
              <!-- Start blog sidebar -->
              <div class="col-md-4">
                <aside class="aa-blog-sidebar">                                
                  <div class="aa-blog-sidebar-single">                    
                    <div class="aa-banner-ads">
                      <a href="#">
                        <img src="img/banner-ads.jpg" alt="banner img">
                      </a>
                    </div>                    
                  </div>
                </aside>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Blog  -->

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
<%}%>