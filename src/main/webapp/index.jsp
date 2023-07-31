<%@page import="DAO.AccountDBHelper"%>
<%@page import="java.util.Objects"%>
<%@page import="bean.UserAccount"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="bean.AdImmobile"%>
<%@page import="DAO.AdDBHelper"%>
<%@page import="java.sql.SQLException"%>
<%@ page import = "bean.Address" %>
<%@ page import = "DAO.AddressDBHelper" %>
<%@ page import = "java.util.List" %>

<%
String sqlException = null;
String selectedCounty = null;
int maxUsableArea = 0;
int maxPrice = 0;
List<AdImmobile> ads = null;
List<Address> counties = null;
AdDBHelper adDBHelper = new AdDBHelper();
AddressDBHelper adressDBHelper = new AddressDBHelper();
AccountDBHelper accountDBHelper = new AccountDBHelper();
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
List<UserAccount> realtors = accountDBHelper.getRealtors();

  try{	 	  
	  ads = adDBHelper.getLastActiveAds();
	  counties = adressDBHelper.getAllCounty();
	  maxUsableArea = immobileDBHelper.getMaxUsableArea();
	  maxPrice = adDBHelper.getMaxPrice();
  }
  catch(SQLException e)
  {
	  sqlException = e.getMessage();
  }


if(sqlException != null)
{
	response.sendRedirect("404.jsp");
}
else
{
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Acasa</title>    
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
   minUsableArea {
	  height: 150px; 
	  overflow-y: scroll; 
  } 
   </style>
  <script>	
  function setTypeByCategory()
  {
	  var category = document.getElementById("category").value;
	  var type = document.getElementById("type");
	   
	  var optionType = new Option("Tip", "Tip");
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
            <li class="active"><a href="index.jsp">ACASA</a></li>
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

  <!-- Start slider  -->
  <section id="aa-slider">
    <div class="aa-slider-area"> 
      <!-- Top slider -->
      <div class="aa-top-slider">
        <!-- Top slider single slide -->
        <div class="aa-top-slider-single">
          <img src="img/slider/3.jpg" alt="img">
          <!-- Top slider content -->
          <div class="aa-top-slider-content">
            <br><br>
            <h2 class="aa-top-slider-title">Revolutionam cautarea</h2><br>
            <p class="aa-top-slider-price">Alege din cele mai bune proprietati locul caruia sa ii spui acasa</p>
            <br>
          </div>
          <!-- / Top slider content -->
        </div>
        <!-- / Top slider single slide -->
        <!-- Top slider single slide -->
        <div class="aa-top-slider-single">
          <img src="img/slider/2.jpg" alt="img">          
        </div>
        
        <!-- / Top slider single slide -->
        <!-- Top slider single slide -->
        <div class="aa-top-slider-single">
          <img src="img/slider/1.jpg" alt="img">        
        </div>
        <!-- / Top slider single slide -->       
         <!-- Top slider single slide -->
        <div class="aa-top-slider-single">
          <img src="img/slider/5.jpg" alt="img">
        </div>
        <!-- / Top slider single slide -->        
         <!-- Top slider single slide -->
        <div class="aa-top-slider-single">
          <img src="img/slider/4.jpg" alt="img">
        </div>
        <!-- / Top slider single slide -->
         <!-- Top slider single slide -->
        <div class="aa-top-slider-single">
          <img src="img/slider/6.jpg" alt="img">
        </div>
        <!-- / Top slider single slide -->
      </div>
    </div>
  </section>
  <!-- End slider  -->  

  <!-- Advance Search -->
  <form name="searchForm" action="searchImmobile.jsp">
  <section id="aa-advance-search">
    <div class="container">
      <div class="aa-advance-search-area">
        <div class="form">
        
         <div class="aa-advance-search-top">
            <div style="display:flex; justify-content:space-between;" class="row">
             <div class="col-md-2">
               <div class="aa-single-advance-search">
                  <select style="width:230px;" name="county" id="county">
				    <option value="Judet">Judet</option>
				    <%for(Address adress : counties){ %>
				    <option value="<%=adress.getCounty()%>"><%=adress.getCounty() %></option>
				    <%} %>
				  </select>
               </div>
              </div>             
              <div class="col-md-2">
                <div class="aa-single-advance-search">
                  <select style="width:230px;" name="category" id="category" onchange="setTypeByCategory()">
                    <option value="Categorie" selected>Categorie</option>
                    <option value="ApartamentGarsoniera">Apartament-Garsoniera</option>
                    <option value="Casa">Casa</option>
                    <option value="Teren">Teren</option>
                  </select>
                </div>
              </div>
              <div class="col-md-2">
                 <div class="aa-single-advance-search">
                  <select style="width:230px;" name="type" id="type">
                    <option value="Tip" selected>Tip</option>
                    <option value="Vanzare">Vanzare</option>
                    <option value="Inchiriere">Inchiriere</option>
                  </select>
              </div>
              </div>              
              <div class="col-md-2">
                <div style="width:230px;" class="aa-single-advance-search">
                  <input class="aa-search-btn" type="submit" value="Cauta">
                </div>
              </div>
            </div>
          </div>
          
         <div class="aa-advance-search-bottom">
           <div class="row">
            <div class="col-md-6">
              <div class="aa-single-filter-search">
                <span>SUPRAFATA (mp)</span>
                <span>DE LA</span>                           
                  <select style="width:100px; height:25px" name="minUsableArea" id="minUsableArea">
				    <%for(int i=0; i<=maxUsableArea; i++){ %>
					    <option value="<%=i%>"><%=i%></option>
					    <%if(i < 100){
					    	i += 9;
					    }
					    else if(i < 400){
					    	i+= 99;
					    }
					    else{
					    	i+= 199;
					    }
				        %>				    
				    <%} %>
				  </select>                
                <span>PANA LA</span>              
                  <select style="width:100px; height:25px" name="maxUsableArea" id="maxUsableArea">
				    <%for(int i=0; i<=maxUsableArea; i++){ %>
					    <option value="<%=i%>"><%=i%></option>
					    <%if(i < 100){
					    	i += 9;
					    }
					    else if(i < 400){
					    	i+= 99;
					    }
					    else{
					    	i+= 199;
					    }
				        %>				    
				    <%} %>
				  </select>                                               
              </div>
            </div>
            <div class="col-md-6">
              <div class="aa-single-filter-search">
                <span>PRET (LEI)</span>
                <span>DE LA</span>                           
                  <select style="width:100px; height:25px" name="minPrice" id="minPrice">
				    <%for(int i=0; i<=maxPrice; i++){ %>
					    <option value="<%=i%>"><%=i%></option>
					    <%if(i < 10000){
					    	i += 999;
					    }
					    else if(i < 50000){
					    	i+= 9999;
					    }
					    else{
					    	i+= 99999;
					    }
				        %>				    
				    <%} %>
				  </select>                  
                <span>PANA LA</span>              
                  <select style="width:100px; height:25px" name="maxPrice" id="maxPrice">
				    <%for(int i=0; i<=maxPrice; i++){ %>
					    <option value="<%=i%>"><%=i%></option>
					    <%if(i < 10000){
					    	i += 999;
					    }
					    else if(i < 50000){
					    	i+= 9999;
					    }
					    else{
					    	i+= 99999;
					    }
				        %>				    
				    <%} %>
				  </select>      
              </div>
            </div>
          </div>  
         </div>
         
        </div>
      </div>
    </div>
  </section>
  </form>
  <!-- / Advance Search -->

  <!-- About us -->
  <section id="aa-about-us">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-about-us-area">
            <div class="row">
              <div class="col-md-5">
                <div class="aa-about-us-left">
                  <img src="img/about-us.png" alt="image"><!-- 432x334 -->
                </div>
              </div>
              <div class="col-md-7">
                <div class="aa-about-us-right">
                  <div class="aa-title">
                    <h2>Despre noi</h2>
                    <span></span>
                  </div>
                  <p>HomeStor e spatiul in care locuintele isi gasesc proprietari fericiti. Aici transformi procesul de vanzare-cumparare intr-o experienta 
                  lipsita de griji. Vezi anunturi din toata tara.</p>                  
                  <ul>
                    <li>Cauti usor si rapid oferte atunci cand doresti sa cumperi.</li>
                    <li>Postezi anunturi atunci cand vrei sa vinzi si sa gasesti proprietarii potriviti.</li>
                    <li>Ne asiguram ca orice cumparator este informat, stie ce isi doreste, iar nevoile lui se pliaza cu realitatile pietei.</li>                    
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / About us -->

  <!-- Latest property -->
  <section id="aa-latest-property">
    <div class="container">
      <div class="aa-latest-property-area">
        <div class="aa-title">
          <h2>Cele mai noi imobile</h2>
          <span></span>
        </div>
        <div class="aa-latest-properties-content">
          <div class="row">
                 
            <%for(AdImmobile ad : ads) {%> 
            <div class="col-md-4">
              <article class="aa-properties-item">
                <a href="#" class="aa-properties-item-img">
                  <img src="img/immobileImages/<%=ad.getPicture() %>" alt="img" width="340" height="240">
                </a>
                <%if("Inchiriere".equals(ad.getImmobileType())){ %><div class="aa-tag for-rent"><%}else{ %><div class="aa-tag for-sale"><%} %>
                  <%=ad.getImmobileType()%>
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
                    <h3><a href="#"><%=ad.getAdTitle() %></a></h3>
                    <%if(ad.getDescImmobile().length() <= 80){%><p><%=ad.getDescImmobile()%></p><% }else{%><p><%=ad.getDescImmobile().substring(0, 80) + "..."%></p><%}%>                     
                  </div>
                  <div class="aa-properties-detial">
                    <span class="aa-price">
                      <%=ad.getPriceImmobile() %> LEI
                    </span>
                    <a class="aa-secondary-btn" href="properties_detail.jsp?id=<%=ad.getAdId() %>&cat=<%=ad.getCategoryId() %>" target="_blank">Detalii</a>
                  </div>
                </div>
              </article>
            </div>
            <%} %>                     
                      
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Latest property -->

  <!-- Service section -->
  <section id="aa-service">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-service-area">
            <div class="aa-title">
              <h2>Serviciile noastre</h2>
              <span></span>
              <p>Onestitate, prietenie, sustinere, empatie. Acestea sunt valorile care ne definesc.</p>
            </div>
            <!-- service content -->
            <div class="aa-service-content">
              <div class="row">
                <div class="col-md-3">
                  <div class="aa-single-service">
                    <div class="aa-service-icon">
                      <span class="fa fa-home"></span>
                    </div>
                    <div class="aa-single-service-content">
                      <h4><a href="#">Vanzare Imobile</a></h4>
                      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto repellendus quasi asperiores itaque dolorem at.</p>
                    </div>
                  </div>
                </div>
                <div class="col-md-3">
                  <div class="aa-single-service">
                    <div class="aa-service-icon">
                      <span class="fa fa-check"></span>
                    </div>
                    <div class="aa-single-service-content">
                      <h4><a href="#">Inchiriere Imobile</a></h4>
                      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto repellendus quasi asperiores itaque dolorem at.</p>
                    </div>
                  </div>
                </div>
                <div class="col-md-3">
                  <div class="aa-single-service">
                    <div class="aa-service-icon">
                      <span class="fa fa-crosshairs"></span>
                    </div>
                    <div class="aa-single-service-content">
                      <h4><a href="#">Cautare Imobile</a></h4>
                      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto repellendus quasi asperiores itaque dolorem at.</p>
                    </div>
                  </div>
                </div>
                <div class="col-md-3">
                  <div class="aa-single-service">
                    <div class="aa-service-icon">
                      <span class="fa fa-bar-chart-o"></span>
                    </div>
                    <div class="aa-single-service-content">
                      <h4><a href="#">Analiza Pietei</a></h4>
                      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto repellendus quasi asperiores itaque dolorem at.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Service section -->

  <!-- Promo Banner Section -->
  <section id="aa-promo-banner">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-promo-banner-area">
            <h3>Pentru un "acasa" perfect</h3>
            <p>Stii deja ca procesul de cautare a unei locuinte necesita implicare, rabdare, perseverenta si dorinta de a gasi locul potrivit visurilor tale.</p>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Promo Banner Section -->

  <!-- Our Agent Section-->
  <section id="aa-agents">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-agents-area">
            <div class="aa-title">
              <h2>Agentii nostri imobiliari</h2>
              <span></span>
            </div>
            <!-- agents content -->
            <div class="aa-agents-content">
              <ul class="aa-agents-slider">
              <%for(UserAccount realtor : realtors){ %>
                <li>
                  <div class="aa-single-agents">
                    <div class="aa-agents-img">
                      <%if(realtor.getUserSex() == 'M'){ %> <img src="img/agents/agent-man.png" alt="agent member image"> <%}
                           else {%> <img src="img/agents/agent-woman.png" alt="agent member image"> <%} %> 
                    </div>
                    <div class="aa-agetns-info">
                      <h4><a href="#"><%=realtor.getUserLName() + " " + realtor.getUserFName()%></a></h4>                                 
                    </div>
                  </div>
                </li>
                <%} %>                             
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Our Agent Section-->

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