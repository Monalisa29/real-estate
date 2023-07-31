<%@page import="bean.UserAccount"%>
<%@page import="helper.ImmobileHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.CategoryDBHelper"%>
<%@page import="bean.Category"%>
<%@page import="bean.AdImmobile"%>
<%@page import="DAO.ImmobileDBHelper"%>
<%@page import="DAO.AdDBHelper"%>
<%@page import="java.sql.SQLException"%>
<%@ page import = "bean.AdImmobile" %>
<%@ page import = "bean.Address" %>
<%@ page import = "DAO.AddressDBHelper" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.Objects" %>

<%
ImmobileHelper searchImmobileHelper = new ImmobileHelper();

int maxUsableArea = 0;
int maxPrice = 0;

String sqlException = null;

String selectedCounty = request.getParameter("county");
selectedCounty = searchImmobileHelper.getSelectedCounty(selectedCounty);

String selectedCity = request.getParameter("city");
selectedCity = searchImmobileHelper.getSelectedCity(selectedCity);

String selectedCategory = request.getParameter("category");
selectedCategory = searchImmobileHelper.getSelectedCategory(selectedCategory);

String selectedType = request.getParameter("type");
selectedType = searchImmobileHelper.getSelectedType(selectedType);

String selectedRoomsNr = request.getParameter("roomsNr");
int selectedRoomsNrInt = searchImmobileHelper.getSelectedRoomsNr(selectedRoomsNr);

String selectedPartitioning = request.getParameter("partitioning");
selectedPartitioning = searchImmobileHelper.getSelectedPartitioning(selectedPartitioning);

String selectedBuildYear = request.getParameter("buildYear");
int selectedMinBuildYear = searchImmobileHelper.getSelectedMinBuildYear(selectedBuildYear);
int selectedMaxBuildYear = searchImmobileHelper.getSelectedMaxBuildYear(selectedBuildYear);

String selectedMinUsableArea = request.getParameter("minUsableArea");
int selectedMinUsableAreaInt = searchImmobileHelper.getSelectedUsableArea(selectedMinUsableArea);

String selectedMaxUsableArea = request.getParameter("maxUsableArea");
int selectedMaxUsableAreaInt = searchImmobileHelper.getSelectedUsableArea(selectedMaxUsableArea);

String selectedMinPrice = request.getParameter("minPrice");
int selectedMinPriceInt = searchImmobileHelper.getSelectedPrice(selectedMinPrice);

String selectedMaxPrice = request.getParameter("maxPrice");
int selectedMaxPriceInt = searchImmobileHelper.getSelectedPrice(selectedMaxPrice);

List<AdImmobile> ads = null;
List<Address> counties = null;
List<Address> cities = null;
List<Category> categories = null;

Category landCategory = new Category();
landCategory.setCategoryType("Vanzare");

AddressDBHelper adressDBHelper = new AddressDBHelper();
AdDBHelper adDBHelper = new AdDBHelper();
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
CategoryDBHelper categoryDBHelper = new CategoryDBHelper();
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");

  try{
	  ads = adDBHelper.getAdsByFilters(selectedCounty, selectedCity, selectedCategory, selectedType, selectedRoomsNrInt, selectedPartitioning, selectedMinBuildYear, selectedMaxBuildYear, selectedMinUsableAreaInt, selectedMaxUsableAreaInt, selectedMinPriceInt, selectedMaxPriceInt);
	  counties = adressDBHelper.getAllActivesCounties();
	  maxUsableArea = immobileDBHelper.getMaxUsableArea();
	  maxPrice = adDBHelper.getMaxPrice();	  
	  
	  if(selectedCounty != null && !selectedCounty.equals("Judet")){
		  cities = adressDBHelper.getAllCitiesByCounty(selectedCounty);
	  }
	  else{
		  cities = adressDBHelper.getAllCities();  
	  }
	  
	  if(selectedCategory != null && selectedCategory.equals("Teren"))
	  {
		  categories = new ArrayList<Category>();
		  categories.add(landCategory);
	  }	        
	  else
	  {
		  categories = categoryDBHelper.getAllCategories();
	  }
	  
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
    <title>HomeStor | Anunturi</title>
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
  	.noAdsMess{
  		font-size:25px;
  		font-weight:600;
  		margin-top:240px;
  		margin-bottom:320px;
  		margin-left:20px;
  	}
  	.resetFiltersButton{
  	    height: 25px;
  	    width: 320px;
  	    margin-top: 5px;
  	    border-radius: 5px;
  	    border: none; 
  		background-color: #59abe3;
  		color: #ffffff;
  	}
  </style>
  <script>
   function setCityByCounty(){
	   var county = document.getElementById("county").value;
	   var city = document.getElementById("city").value;
	   if(county != null){	  	   	   
		 document.getElementById("filtersSearch").submit();	 
	   }
   }
   
   function setTypeByCategory(){
	   var category = document.getElementById("category").value;
	   var type = document.getElementById("type");
	   var roomsNr = document.getElementById("roomsNr");
	   var partitioning = document.getElementById("partitioning");
	   var buildYear = document.getElementById("buildYear");
	   
	   var optionType = new Option("Tip", "Tip");
	   var optionTypeRent = new Option("Inchiriere", "Inchiriere");
	   var optionTypeSale = new Option("Vanzare", "Vanzare");
	   
	   if(category == "Teren"){
		   type.options.length = 0;
		   type.add(optionType);
		   type.add(optionTypeSale);
		   
		   roomsNr.style.display = "none";
		   partitioning.style.display = "none";
		   buildYear.style.display = "none";
	   }	  
	   else if(category == "Casa"){
		   partitioning.style.display = "none";
	   }
	   else{
		   type.options.length = 0;
		   type.add(optionType);
		   type.add(optionTypeRent);
		   type.add(optionTypeSale);
		   
		   roomsNr.style.display = "block";
		   partitioning.style.display = "block";
		   buildYear.style.display = "block";
	   }
   }
   function resetValues(){
	   var county = document.getElementById("county");
	   var city = document.getElementById("city");
	   var category = document.getElementById("category");
	   var type = document.getElementById("type");
	   var roomsNr = document.getElementById("roomsNr");
	   var partitioning = document.getElementById("partitioning");
	   var buildYear = document.getElementById("buildYear");
	   var minUsableArea = document.getElementById("minUsableArea");
	   var maxUsableArea = document.getElementById("maxUsableArea");
	   var minPrice = document.getElementById("minPrice");
	   var maxPrice = document.getElementById("maxPrice");
	   
	   county.selectedIndex = 0;
	   city.selectedIndex = 0;
	   category.selectedIndex = 0;
	   type.selectedIndex = 0;
	   roomsNr.selectedIndex = 0;
	   partitioning.selectedIndex = 0;
	   buildYear.selectedIndex = 0;
	   minUsableArea.selectedIndex = 0;
	   maxUsableArea.selectedIndex = 0;
	   minPrice.selectedIndex = 0;
	   maxPrice.selectedIndex = 0;
   }
  </script>
  </head>
  <body class="aa-price-range">    
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
            <h2>Anunturi</h2>
            <ol class="breadcrumb">
            <li><a href="#">Anunturi</a></li>            
            <li class="active">Cauta anunturi</li>
            </ol>
          </div>
        </div>
      </div>
    </div>
  </section> 
  <!-- End Proerty header  -->

  <!-- Start Properties  -->
  <section id="aa-properties">
    <div class="container">
      <div class="row">    
        <div class="col-md-8">
          <div class="aa-properties-content">
            <!-- start properties content head -->
            <%if(ads.isEmpty()){ %>
         	<aside class="aa-properties-sidebar">
           	  <div class="aa-properties-single-sidebar">
           	    <h2 class="noAdsMess">Din pacate nu sunt anunturi care sa se potriveasca cu criteriile alese.</h2>
			  </div>
			</aside>
			  <%} 
			  else{%>	
            <div class="aa-properties-content-head">                           
              <div class="aa-properties-content-head-right">
                <a id="aa-grid-properties" href="#"><span class="fa fa-th"></span></a>
                <a id="aa-list-properties" href="#" ><span class="fa fa-list"></span></a>
              </div>            
            </div>                                		  
            <!-- Start properties content body -->
            <div class="aa-properties-content-body">
              <ul class="aa-properties-nav">
              
              <%for(AdImmobile ad : ads){ %>
                <li>                 
                  <article class="aa-properties-item">
                    <a class="aa-properties-item-img" href="">
                      <img alt="img" src="img/immobileImages/<%=ad.getPicture() %>" width="340" height="240">
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
               <%} %>                    
              </ul>
            </div>
            <%} %>
          </div>
        </div>
        <!-- Start properties sidebar -->
        <div class="col-md-4">
          <aside class="aa-properties-sidebar">
            <!-- Start Single properties sidebar -->
            <form name="filtersSearch" id="filtersSearch" action="searchImmobile.jsp" method="get">
            <div class="aa-properties-single-sidebar">
              <h3>FILTRE DE CAUTARE</h3>              
                <div class="aa-single-advance-search">
                  <select name="county" id="county" onchange="setCityByCounty()">
				    <option value="Judet">Judet</option>
				    <%for(Address adress : counties){ %>
				    <option value="<%=adress.getCounty()%>" <%if(!Objects.isNull(selectedCounty) && selectedCounty.equals(adress.getCounty())){ %>selected<%} %> ><%=adress.getCounty() %></option>
				    <%} %>
				  </select>
                </div>
                
                <div class="aa-single-advance-search">
                  <select name="city" id="city">
				    <option value="Oras">Oras</option>
				    <%for(Address adress : cities){ %>
				    <option value="<%=adress.getCity()%>"<%if(!Objects.isNull(selectedCity) && selectedCity.equals(adress.getCity())){ %>selected<%} %> ><%=adress.getCity() %></option>
				    <%} %>
				  </select>
                </div>
                
                <div class="aa-single-advance-search">
                  <select name="category" id="category" onchange="setTypeByCategory()">
                   <option value="Categorie" selected>Categorie</option>
                    <option value="ApartamentGarsoniera" <%if(!Objects.isNull(selectedCategory) && selectedCategory.equals("ApartamentGarsoniera")){ %>selected<%} %> >Apartament-Garsoniera</option>
                    <option value="Casa" <%if(!Objects.isNull(selectedCategory) && selectedCategory.equals("Casa")){ %>selected<%} %> >Casa</option>
                    <option value="Teren" <%if(!Objects.isNull(selectedCategory) && selectedCategory.equals("Teren")){ %>selected<%} %> >Teren</option>
                  </select>
                </div>
                
                <div class="aa-single-advance-search">
                  <select name="type" id="type">
				    <option value="Tip">Tip</option>
				    <%for(Category category : categories){ %>
				    <option value="<%=category.getCategoryType()%>" <%if(!Objects.isNull(selectedType) && selectedType.equals(category.getCategoryType())){ %>selected<%} %> ><%=category.getCategoryType() %></option>
				    <%} %>
				  </select>
                </div>
                
                <div class="aa-single-advance-search">
                  <select name="roomsNr" id="roomsNr">
                    <option value="Numardecamere" selected>Numar de camere</option>
                    <option value="1" <%if(!Objects.isNull(selectedRoomsNr) && selectedRoomsNr.equals("1")){ %>selected<%} %> >1</option>
                    <option value="2" <%if(!Objects.isNull(selectedRoomsNr) && selectedRoomsNr.equals("2")){ %>selected<%} %> >2</option>
                    <option value="3" <%if(!Objects.isNull(selectedRoomsNr) && selectedRoomsNr.equals("3")){ %>selected<%} %> >3</option>
                    <option value="4+" <%if(!Objects.isNull(selectedRoomsNr) && selectedRoomsNr.equals("4+")){ %>selected<%} %> >4+</option>
                  </select>
                </div>   
                
                <div class="aa-single-advance-search">
                  <select name="partitioning" id="partitioning">
                    <option value="compartimentare" selected>Compartimentare</option>
                    <option value="decomandat" <%if(!Objects.isNull(selectedPartitioning) && selectedPartitioning.equals("decomandat")){ %>selected<%} %> >Decomandat</option>
                    <option value="semidecomandat" <%if(!Objects.isNull(selectedPartitioning) && selectedPartitioning.equals("semidecomandat")){ %>selected<%} %> >Semidecomandat</option>
                    <option value="nedecomandat" <%if(!Objects.isNull(selectedPartitioning) && selectedPartitioning.equals("nedecomandat")){ %>selected<%} %> >Nedecomandat</option>
                    <option value="circular" <%if(!Objects.isNull(selectedPartitioning) && selectedPartitioning.equals("circular")){ %>selected<%} %> >Circular</option>
                  </select>
                </div>      
                
                <div class="aa-single-advance-search">
                  <select name="buildYear" id="buildYear">
                    <option value="anConstructie" selected>An constructie</option>
                    <option value="dupa2000" <%if(!Objects.isNull(selectedBuildYear) && selectedBuildYear.equals("dupa2000")){ %>selected<%} %> >Dupa 2000</option>
                    <option value="1990-2000" <%if(!Objects.isNull(selectedBuildYear) && selectedBuildYear.equals("1990-2000")){ %>selected<%} %> >1990 - 2000</option>
                    <option value="1977-2000" <%if(!Objects.isNull(selectedBuildYear) && selectedBuildYear.equals("1977-2000")){ %>selected<%} %> >1977-1990</option>
                    <option value="inainte1977" <%if(!Objects.isNull(selectedBuildYear) && selectedBuildYear.equals("inainte1977")){ %>selected<%} %> >Inainte de 1977</option>
                  </select>
                </div>                     
                                   
                <div class="aa-single-advance-search">
                  <span>Suprafata (mp)</span><br>
                  <span>DE LA</span>
                  <select style="width:103px;" name="minUsableArea" id="minUsableArea" class="dropDownSearch">
				    <%for(int i=0; i<=maxUsableArea; i++){ %>
					    <option value="<%=i%>" <%if(!Objects.isNull(selectedMinUsableArea) && selectedMinUsableArea.equals(Integer.toString(i))){ %>selected<%} %> ><%=i%></option>
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
                  <select style="width:103px;" name="maxUsableArea" id="maxUsableArea" class="dropDownSearch">
				    <%for(int i=0; i<=maxUsableArea; i++){ %>
					    <option value="<%=i%>" <%if(!Objects.isNull(selectedMaxUsableArea) && selectedMaxUsableArea.equals(Integer.toString(i))){ %>selected<%} %> ><%=i%></option>
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
                
                <div class="aa-single-advance-search">
                  <span>Pret (LEI)</span><br>             
                  <span>DE LA</span>
                  <select style="width:103px;" name="minPrice" id="minPrice" class="dropDownSearch">
				    <%for(int i=0; i<=maxPrice; i++){ %>
					    <option value="<%=i%>" <%if(!Objects.isNull(selectedMinPrice) && selectedMinPrice.equals(Integer.toString(i))){ %>selected<%} %> ><%=i%></option>
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
                  <select style="width:103px;" name="maxPrice" id="maxPrice" class="dropDownSearch">
				    <%for(int i=0; i<=maxPrice; i++){ %>
					    <option value="<%=i%>" <%if(!Objects.isNull(selectedMaxPrice) && selectedMaxPrice.equals(Integer.toString(i))){ %>selected<%} %> ><%=i%></option>
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
                                                          
                <div class="aa-single-advance-search">
                  <input type="submit" value="Cauta" class="aa-search-btn">
                  <button class="resetFiltersButton" type="button" onclick="resetValues()">Sterge filtrele</button>
                </div>
               </div>
             </form>
             </aside>
            </div> 
            
        </div>
      </div>
  </section>
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
<%}%>