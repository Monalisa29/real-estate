<%@page import="java.util.List"%>
<%@page import="bean.UserAccount"%>
<%@page import="DAO.AdDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%@page import="java.util.Objects"%>
<%
String messInsert = request.getParameter("mess");
String messUpdate = request.getParameter("messU");
UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
AdDBHelper adDBHelper = new AdDBHelper();
List<AdImmobile> ads = adDBHelper.getAdsByUser(userAccount.getUserId());
String selectedStatus = request.getParameter("adStatus");
int adsNr = 0;
if(Objects.isNull(selectedStatus)){
	selectedStatus = "activ";
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
    <title>HomeStor | Anunturile mele</title>
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
  jQuery(document).ready(function() {
	    jQuery("#aa-list-properties").addClass("active");
	    jQuery(".aa-properties-nav").addClass("aa-list-view");
  });
    function showAdsByStatus()
    {
       var status = document.getElementById("adStatus").value;
 	   if(status != null){	  	   	   
 		 document.getElementById("adsForm").submit();	 
 	   }
    }
  </script> 
  <style>
	  .aa-secondary-btn{
	 	 margin-right: 4px; 
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
            <h2>Anunturile mele</h2>  
            <ol class="breadcrumb">
            <li><a href="#">Contul meu</a></li>            
            <li class="active">Anunturile mele</li>
            </ol>          
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->

  <!-- Start Properties  -->
  <form name="adsForm" id="adsForm" action="myAds.jsp" method="post">
  <section id="aa-properties">
    <div class="container">   
     <div class="row">
      <div class="col-md-8">
      <div class="aa-properties-content">	
        <!-- start properties content head -->          
        <%if(ads.isEmpty()){ %>
        <aside class="aa-properties-sidebar">
          <div class="aa-properties-single-sidebar">
           	 <h2 style="font-size:25px;font-weight:600;margin-top:240px;margin-bottom:320px;margin-left:20px;">Nu ati postat inca niciun anunt.</h2>
		  </div>
	    </aside>
	     <%} 
		  else{%>				  				                     		  
            <!-- Start properties content body -->
            <div class="aa-properties-content-body">
            <div class="aa-properties-content-head">                                       
              <div class="aa-single-advance-search">
	            <%if(!Objects.isNull(messInsert) && messInsert.equals("1")){ %>
	              <p style="color:green;">Anuntul a fost adaugat cu succes.</p>
	            <%} 
	              else if(!Objects.isNull(messInsert) && messInsert.equals("0")){%>
	              <p style="color:red;">Anuntul nu a putut fi adaugat. Incercati mai tarziu.</p>            
	              <% }%>       
	                   
	              <%if(!Objects.isNull(messUpdate) && messUpdate.equals("1")){ %>
	              <p style="color:green;">Anuntul a fost modificat cu succes.</p>
	              <%} else if(!Objects.isNull(messUpdate) && messUpdate.equals("0")){%>
	              <p style="color:red;">Anuntul nu a putut fi modificat. Incercati mai tarziu.</p>            
	              <% }%>                              
                 <span style="color:#59abe3;font-weight:bold;">Status anunturi:</span>
                  <select style="width:150px;" name="adStatus" id="adStatus" onchange="showAdsByStatus()">
                    <option value="activ" <%if(selectedStatus.equals("activ")){ %> selected <%} %>>Active</option>
                    <option value="in asteptare" <%if(selectedStatus.equals("in asteptare")){ %> selected <%} %>>In asteptare</option>
                    <option value="respins" <%if(selectedStatus.equals("respins")){ %> selected <%} %>>Respinse</option>
                  </select>
                </div>
              </div>
              <ul class="aa-properties-nav">             
              <%for(AdImmobile ad : ads){ %>
               <%if(selectedStatus.equals(ad.getAdStatus())){
            	   adsNr++;%>
                <li>                 
                  <article class="aa-properties-item">
                    <a class="aa-properties-item-img" href="">
                      <img alt="img" src="img/immobileImages/<%=ad.getPicture() %>">
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
                        <span> </span>
                        <%if(selectedStatus.equals("activ") || selectedStatus.equals("in asteptare")){ %>
                        <span><a class="aa-secondary-btn" href="modifyAd.jsp?id=<%=ad.getAdId() %>&cat=<%=ad.getCategoryId() %>">Modifica</a></span>
                        <%} %>
                        <span> </span>                   
                        <span><a class="aa-secondary-btn" href="properties_detail.jsp?id=<%=ad.getAdId() %>&cat=<%=ad.getCategoryId() %>" target="_blank">Detalii</a></span>    
                        <span> </span>                
                      </div>
                    </div>
                  </article>
                </li>      
                <%} 
               } %>                                               
              </ul>
              <%if(adsNr == 0){ %>
		        <aside class="aa-properties-sidebar">
		          <div class="aa-properties-single-sidebar">
		           	 <h2 style="font-size:25px;font-weight:600;margin-top:50px;margin-bottom:320px;margin-left:20px;">Nu aveti anunturi cu acest status.</h2>
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