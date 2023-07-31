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
String messInsert = request.getParameter("mess");

UserAccount userAccount = (UserAccount) session.getAttribute("currentUser");
ImmobileDBHelper immobileDBHelper = new ImmobileDBHelper();
ImmobileHelper immobileHelper = new ImmobileHelper();
List<AdImmobile> immobileList = null;
Map<String,List<String>> countiesCities = null;
List<String> citiesAlba = null;

if(Objects.isNull(userAccount)){
	session.setAttribute("signinFromPage", "addI");
	response.sendRedirect("signin.jsp");	
}
else{
	try{
		immobileList = immobileDBHelper.getImmobileListByUserId(userAccount.getUserId());		
		countiesCities = immobileHelper.getCountiesCities();
		citiesAlba = countiesCities.get("Alba");
	}
	catch(SQLException e)
	{
		  sqlException = e.getMessage();
	}
	
	if(sqlException != null){
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
	.detailsTable {
	  border-collapse: collapse;
	  width: 50%;
	}
	.detailsTable td,th{
      padding: 9px;
  	  text-align: left;
      border-bottom: 2px solid #ddd;
	}
	.submitButton{
	  background-color:#59abe3; 
	  color:#fff; 
	  padding:5px 10px; 
	  border:none
	}
	input[type="radio"] {
      cursor: pointer;
    }
 </style>
 <script> 
 
 function toggleSection(icon)
 {
	 var sectiune1 = document.getElementById("optionImmobileBlock");
	 var sectiune2 = document.getElementById("optionNewImBlock");
	 
	 if (icon.id === "myImmobileSection") {
		 if (sectiune1.style.display === "none") {
		    sectiune1.style.display = "block";
		    sectiune2.style.display = "none";
		    icon.src = "img/icons/down-arrow.png";
		    
		    var iconSectiuneDoi = document.getElementById("newImmobileSection");
		    iconSectiuneDoi.src = "img/icons/next.png";
		 }
		 else{
			 sectiune1.style.display = "none"
			 icon.src = "img/icons/next.png";			 			 
		 }
	} else {
		if(sectiune2.style.display === "none"){
			sectiune1.style.display = "none";
		    sectiune2.style.display = "block";
		    icon.src = "img/icons/down-arrow.png";
		    
		    var iconPrimaSectiune = document.getElementById("myImmobileSection");
		    iconPrimaSectiune.src = "img/icons/next.png";
		}
		else{
			sectiune2.style.display = "none"
			icon.src = "img/icons/next.png";
		}    
	}
 }
 
   function setSelectedValueAd(value)
   {	   
	   var selectedValue = value;
	   var element = document.getElementById("immobileHrefs");
	   
	   document.getElementById("hiddenId").value = selectedValue;
	   element.removeAttribute("hidden");
   }
   
   function setValueOnLink()
   {
	   var linkDetails = document.getElementById("linkDetails");
	   var linkNewAd = document.getElementById("linkNewAd");
	   var id = document.getElementById("hiddenId").value;
	   
	   if (linkDetails.href.indexOf("id=") === -1) {
		   linkDetails.href += "?id="+id;
	   }
	   else{
		   linkDetails.href = linkDetails.href.replace(/(id=)[^\&]+/, "$1" + id);
	   }
	   
	   if (linkNewAd.href.indexOf("id=") === -1) {
		   linkNewAd.href += "?id="+id;
	   }
	   else{
		   linkNewAd.href = linkNewAd.href.replace(/(id=)[^\&]+/, "$1" + id);
	   }
   }
   
   function setCityByCounty()
   {
	   var citiesDropD = document.getElementById("city");
	   var selectedCounty = document.getElementById("county").value;
	   citiesDropD.options.length = 0;
	   
	   var countyCities = [
	   {county: "Alba", cities: ["", "Alba Iulia", "Abrud", "Aiud", "Baia de Aries", "Blaj", "Campeni", "Cugir", "Ocna Mures", "Sebes", "Teius", "Zlatna"] },
	   {county: "Arad",cities: ["", "Arad", "Chisineu Cris", "Curtici", "Ineu", "Lipova", "Nadlac", "Pancota", "Pecica", "Santana", "Seius"] },
	   {county: "Arges",cities: ["", "Campulung", "Costesti", "Curtea de Arges", "Mioveni", "Pitesti", "Stefanesti", "Topoloveni"] },
	   {county: "Bacau",cities: ["", "Bacau", "Buhusi", "Comanesti", "Darmanesti", "Moinesti", "Onesti", "Slanic-Moldova", "Targu Ocna"] },
	   {county: "Bihor",cities: ["", "Alesd", "Beius", "Marghita", "Nucet", "Oradea", "Sacueni", "Salonta", "Stei", "Valea lui Mihai", "Vascau"] },
	   {county: "Bistrita-Nasaud",cities: ["", "Bistrita", "Beclean", "Sangeorz-Bai", "Nasaud"] },
	   {county: "Botosani",cities: ["", "Botosa ni", "Bucecea", "Dorohoi", "Darabani", "Flamanzi", "Saveni", "Stefanesti"] },
	   {county: "Brasov",cities: ["", "Brasov", "Codlea", "Fagaras", "Ghimbav", "Predeal", "Rasnov", "Rasnov", "Rupea", "Sacele", "Victoria", "Zarnesti"] },
	   {county: "Braila",cities: ["", "Braila", "Ianca", "Insuratei", "Faurei"] },
	   {county: "Bucuresti",cities: ["", "Clinceni", "Tunari", "1 Decembrie", "Berceni", "Chiajna", "Chitila", "Gradistea", "Jilava", "Moara Vlasiei", "Peris", "Cornetu", "Ciolpani", "Corbeanca", "Gruiu", "Snagov", "Cernica", "Vidra", "Voluntari", "Balotesti", "Bragadiru", "Glina", "Otopeni", "Pantelimon", "Petrachioaia", "Popesti Leordeni", "Ciorogarla", "Crevedia", "Darasti-Ilfov", "Dascalu", "Dobroesti", "Domnesti", "Dragomiresti-Vale", "Dridu", "Fierbinti-Targ", "Fundeni", "Ganeasa", "Gradinari", "Magurele", "Mogosoaia", "Afumati", "Branesti", "Bucuresti", "Buftea", "Stefanestii De Jos", "Nuci"] },
	   {county: "Buzau",cities: ["", "Buzau", "Ramnicu Sarat", "Nehoiu", "Patarlagele", "Pogoanele"] },
	   {county: "Caras-Severin",cities: ["", "Resita", "Caransebes", "Bocsa", "Moldova Noua", "Oravita", "Otelu Rosu", "Anina", "Baile Herculane"] },
	   {county: "Calarasi", cities: ["", "Calarasi", "Oltenita", "Budesti", "Fundulea", "Lehliu-Gara"] },
	   {county: "Cluj", cities: ["", "Cluj-Napoca", "Campia Turzii", "Dej", "Gherla", "Huedin", "Turda"] },
	   {county: "Constanta", cities: ["", "Constanta", "Baneasa", "Cernavoda", "Eforie", "Harsova", "Mangalia", "Medgidia", "Murfatlar", "Navodari", "Negru Voda", "Ovidiu", "Techirghiol"] },
	   {county: "Covasna", cities: ["", "Baraolt", "Covasna", "Intorsura Buzaului", "Sfantu Gheorghe", "Tragu Secuiesc"] },
	   {county: "Dambovita", cities: ["", "Fleni", "Gaesti", "Moreni", "Pucioasa", "Racari", "Targoviste", "Titu"] },
	   {county: "Dolj", cities: ["", "Bailesti", "Bechet", "Calafat", "Craiova", "Dabulesti", "Filiasi", "Segarcea"] },
	   {county: "Galati", cities: ["", "Beresti", "Galati", "Targu Bujor", "Tecuci"] },
	   {county: "Giurgiu", cities: ["", "Bolintin-Vale", "Giurgiu", "Mihailesti"] },
	   {county: "Gorj", cities: ["", "Bumbesti-Jiu", "Calan", "Hateg", "Motru", "Novaci", "Petrila", "Rovinari", "Targu Carbunesti", "Targu Jiu", "Ticleni", "Turceni", "Tismana", "Uricani"] },
	   {county: "Harghita", cities: ["", "Balan", "Baile Tusnad", "Borsec", "Cristuru Secuiesc", "Gheorgheni", "Miercurea-Ciuc", "Odorheiu Secuiesc", "Toplita", "Vlahita"] },
	   {county: "Hunedoara", cities: ["", "Aninoasa", "Brad", "Calan", "Deva", "Geoagiu", "Hateg", "Lupeni", "Orastie", "Petrosani", "Simeria", "Targu Carbunesti", "Targu Jiu", "Turceni", "Uricani", "Vulcan"] },
	   {county: "Ialomita", cities: ["", "Amara", "Cazanesti", "Fetesti", "Fierbinti-Targ", "Slobozia", "Tandarei","Urziceni"] },
	   {county: "Iasi", cities: ["", "Iasi", "Pascani", "Harlau", "Podu Iloaiei", "Targu Frumos", "Hirlau"] },
	   {county: "Ilfov", cities: ["", "Buftea", "Pantelimon", "Popesti-Leordeni", "Voluntari", "Chitila", "Corbeanca", "Magurele", "Otopeni"] },
	   {county: "Maramures", cities: ["", "Baia Mare", "Sighetu Marmatiei", "Borsa", "Targu Lapus", "Somcuta Mare", "Dragomiresti", "Seini", "Cavnic"] },
	   {county: "Mehedinti", cities: ["", "Drobeta-Turnu Severin", "Orsova", "Strehaia", "Vanju Mare", "Baia de Arama"] },
	   {county: "Mures", cities: ["", "Targu Mures", "Reghin", "Sighisoara", "Sovata", "Tarnaveni", "Ungheni", "Iernut"] },
	   {county: "Neamt", cities: ["", "Piatra Neamt", "Roman", "Roznov", "Targu Neamt", "Bicaz", "Radauti-Prut", "Raucesti"] },
	   {county: "Olt", cities: ["", "Caracal", "Corabia", "Draganesti-Olt", "Piatra-Olt", "Potcoava", "Slatina", "Scornicesti"] },
	   {county: "Prahova", cities: ["", "Ploiesti", "Campina", "Breaza", "Baicoi", "Sinaia", "Slanic", "Valenii de Munte", "Urlati"] },
	   {county: "Salaj", cities: ["", "Zalau", "Jibou", "Simleu Silvaniei", "Cehu Silvaniei"] },
	   {county: "Satu Mare", cities: ["", "Satu Mare", "Carei", "Livada", "Tasnad"] },
	   {county: "Sibiu", cities: ["", "Sibiu", "Agnita", "Avrig", "Cisnadie", "Medias", "Miercurea Sibiului", "Saliste", "Talmaciu"] },
	   {county: "Suceava", cities: ["", "Suceava", "Falticeni", "Radauti", "Cajvana", "Dolhasca", "Vatra Dornei", "Gura Humorului", "Siret", "Campulung Moldovenesc"] },
	   {county: "Teleorman", cities: ["", "Rosiori de Vede", "Turnu Magurele", "Alexandria", "Zimnicea", "Videle"] },
	   {county: "Timis", cities: ["", "Timisoara", "Lugoj", "Sannicolau Mare", "Buzias", "Ciacova", "Deta", "Faget", "Jimbolia"] },
	   {county: "Tulcea", cities: ["", "Tulcea", "Babadag", "Isaccea", "Macin", "Sulina"] },
	   {county: "Valcea", cities: ["", "Ramnicu Valcea", "Dragasani", "Baile Govora", "Berbesti", "Calimanesti", "Horezu", "Brezoi", "Ocnele Mari"] },
	   {county: "Vaslui", cities: ["", "Vaslui", "Barlad", "Husi", "Negresti", "Murgeni", "Dranceni", "Padureni"] },
	   {county: "Vrancea", cities: ["", "Focsani", "Adjud", "Marasesti", "Odobesti", "Panciu"] }
	   ];
	   var selectedCities = countyCities.find(function(item) {
		    return item.county === selectedCounty;
		  });	
  
	   if (selectedCities) {
		    selectedCities.cities.forEach(function(city) {
		      var optionCities = new Option(city, city);
		      citiesDropD.add(optionCities);
		    });
	   }
	   else {
		   var albaCities = countyCities.find(function(item) {
			      return item.county === "Alba";
			    });
		   		    
		    albaCities.cities.forEach(function(city) {
		      var optionCities = new Option(city, city);
		      citiesDropD.add(optionCities);
		    });
		  }	  
   }
   
   function validateForm()
   {
	   var usableArea = document.getElementById('usableArea').value;
	   var description = document.getElementById('description').value;
	   var county = document.getElementById('county').value;
	   var city = document.getElementById('city').value;
	   var streetName = document.getElementById('streetName').value;
	   var adressNr = document.getElementById('adressNr').value;
	   var year = document.getElementById('year').value;
	   var category = document.getElementById('category').value;
	   var roomsNr = document.getElementById('roomsNr').value;
	   var floorAp = document.getElementById('floorAp').value;
	   var floorsNrHouse = document.getElementById('floorsNrHouse').value;
	   var partitioning = document.getElementById('partitioning').value;
	   var picture = document.getElementById('picture').value;
	   
	   if(usableArea == ""){
		   alert("Campul 'Suprafata utila' este obligatoriu!");
		   return false;
	   }
	   else if(isNaN(usableArea) == true || Math.sign(usableArea) === -1 || usableArea.indexOf(".") != -1 || usableArea.indexOf(",") != -1){
		   alert("Suprafata utila trebuie sa fie un numar mai mare decat 0");
		   return false;
	   }
	   else if(county == ""){
		   alert("Campul 'Judet' este obligatoriu!");
		   return false;
	   }
	   else if(city == ""){
		   alert("Campul 'Oras' este obligatoriu!");
		   return false;
	   }     
	   else if(streetName == ""){
		   alert("Campul 'Strada' este obligatoriu!");
		   return false;
	   }
	   else if(adressNr == ""){
		   alert("Campul 'Numar' este obligatoriu!");
		   return false;
	   }
	   else if(isNaN(adressNr) == true || Math.sign(adressNr) === -1 || adressNr.indexOf(".") != -1 || adressNr.indexOf(",") != -1){
		   alert("Numarul este completat incorect");
		   return false;
	   }
	   else if(description == ""){
		   alert("Campul 'Descriere' este obligatoriu!");
		   return false;
	   }   
	   else if(picture == ""){
		   alert("Campul 'Poza' este obligatoriu!");
		   return false;
	   }
	   else if(category == ""){
		   alert("Campul 'Categorie' este obligatoriu!");
		   return false;
	   }
	   else if((category == "Casa" || category == "ApartamentGarsoniera") && year == ""){
		   alert("Campul 'An constructie' este obligatoriu!");
		   return false;
	   }
	   else if((category == "Casa" || category == "ApartamentGarsoniera") && (isNaN(year) == true || Math.sign(year) === -1 || year.indexOf(".") != -1 || year.indexOf(",") != -1 || year.length != 4)){
		   alert("Anul constructiei este completat incorect");
		   return false;
	   }
	   else if((category == "Casa" || category == "ApartamentGarsoniera") && roomsNr == "0"){
		   alert("Campul 'Numar de camere' este obligatoriu!");
		   return false;
	   }
	   else if((category == "Casa" || category == "ApartamentGarsoniera") && (isNaN(roomsNr) == true || Math.sign(roomsNr) === -1 || roomsNr.indexOf(".") != -1 || roomsNr.indexOf(",") != -1)){
		   alert("Campul 'Numar de camere' este completat incorect");
		   return false;
	   }
	   else if(category == "ApartamentGarsoniera" && floorAp == ""){
		   alert("Campul 'Etaj' este obligatoriu!");
		   return false;
	   }
	   else if(category == "ApartamentGarsoniera" && (isNaN(floorAp) == true || Math.sign(floorAp) === -1 || floorAp.indexOf(".") != -1 || floorAp.indexOf(",") != -1)){
		   alert("Campul 'Etaj' este completat incorect");
		   return false;
	   }
	   else if(category == "Casa" && floorsNrHouse == ""){
		   alert("Campul 'Numar de etaje' este obligatoriu!");
		   return false;
	   }
	   else if(category == "Casa" && (isNaN(floorsNrHouse) == true || Math.sign(floorsNrHouse) === -1 || floorsNrHouse.indexOf(".") != -1 || floorsNrHouse.indexOf(",") != -1)){
		   alert("Campul 'Numar de etaje' este completat incorect");
		   return false;
	   }
	   else if(category == "ApartamentGarsoniera" && partitioning == ""){
		   alert("Campul 'Compartimentare' este obligatoriu!");
		   return false;
	   }
	
	   document.newImmobile.submit();
   }
   
   function setLabelsForCategory()
   {
	  var category = document.getElementById("category").value;	  
	  var paritioningDiv = document.getElementById("paritioningDiv");
	  var floorApDiv = document.getElementById("floorApDiv");
	  var floorsNrHouseDiv = document.getElementById("floorsNrHouseDiv");
	  var yearDiv = document.getElementById("yearDiv");
	  var roomsNrDiv = document.getElementById("roomsNrDiv");
	  
	   if(category == "Teren" || category == ""){
		  yearDiv.style.display = "none";  
		  roomsNrDiv.style.display = "none";
	   }	
	   else{
		  yearDiv.style.display = "block";
		  roomsNrDiv.style.display = "block";
	   }
	   	  	   	   	   
	   if(category == "ApartamentGarsoniera"){
		   paritioningDiv.style.display = "block";
		   floorApDiv.style.display = "block";
	   }
	   else
	   {
		   paritioningDiv.style.display = "none";
		   floorApDiv.style.display = "none";
	   }
	   
	   if(category == "Casa"){
		   floorsNrHouseDiv.style.display = "block";
	   }
	   else
	   {
		   floorsNrHouseDiv.style.display = "none";
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
            <h2>POSTEAZA UN ANUNT</h2>
            <ol class="breadcrumb">
            <li><a href="#">Anunturi</a></li>            
            <li class="active">Posteaza anunt</li>
            </ol>
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
  <form name="newImmobile" id="newImmobile" action="insertImmobile.jsp" method="POST" enctype="multipart/form-data"> 
  <aside class="aa-properties-sidebar">  
    <!-- Your immobile -->
    <div class="container">
     <div class="aa-properties-single-sidebar">
       <h3 style="color:#59abe3;"><b>Adauga anunt pentru un imobil deja inregistrat sau inregistreaza unul nou</b></h3> 
     </div> 
      <span style="color:green;"><%if(!Objects.isNull(messInsert) && messInsert.equals("1")){ %> Imobilul a fost inregistrat cu succes <%} %></span>
      <span style="color:red;"><%if(!Objects.isNull(messInsert) && messInsert.equals("0")){ %> Imobilul nu a putut fi inregistrat. Incercati mai tarziu. <%} %></span><br>
      <span style="color:#59abe3;"><b><img class="arrow" id="myImmobileSection" src="img/icons/next.png" alt="arrow-down" onclick="toggleSection(this)"/>Imobilele tale:</b></span>
	      <div id="optionImmobileBlock" style="display:none">   
	       <%if(!immobileList.isEmpty()){ %>    
	      	<table class="detailsTable">
	      	  <tr>
	      	    <th><span></span></th>
			    <th>Suprafata utila (mp)</th>
			    <th>Judet</th>
			    <th>Oras</th>
			    <th>Strada</th>
			    <th>Numar</th>		    
			  </tr>
			  <%for(AdImmobile immobile : immobileList) {%>
			  <tr>
			    <td><input value="<%=immobile.getImmobileId() %>" id="rbImmobileId" name="rbImmobileId" type="radio" onclick="setSelectedValueAd(this.value)" /></td>
			    <td><%=immobile.getUsableArea() %></td>
			    <td><%=immobile.getCounty() %></td>
			    <td><%=immobile.getCity() %></td>
			    <td><%=immobile.getStreedName() %></td>
			    <td><%=immobile.getAddressNr()%></td>
			  </tr>
			  <%} %>
	      	</table><br>
	      	<%}else{ %>   
	   			<h4>Nu ati inregistrat inca niciun imobil.</h4>
	  		 <%} %>
	      	<div id="immobileHrefs" hidden="hidden">
	      	<a class="aa-secondary-btn" href="newAd.jsp" id="linkNewAd" onclick="setValueOnLink()">Adauga anunt</a>
	      	<a class="aa-secondary-btn" href="immobileDetails.jsp" id="linkDetails" target="_blank" onclick="setValueOnLink()">Detalii</a><br><br>	<br>
	      	</div>
	      	<input type="hidden" id="hiddenId" name="hiddenId" value="">     	
	      </div>	   
    </div>
    <!-- End your immobile -->
    
    <!-- Add new immobile -->
    <div class="container">
      <p style="color:#59abe3;"><img class="arrow" id="newImmobileSection"  src="img/icons/next.png" alt="arrow-right" onclick="toggleSection(this)"/><b>Inregistreaza un nou imobil:</b></p>   
       <div id="optionNewImBlock" style="display:none">  
	    <label for="usableArea">Suprafata utila (mp)</label><br>
        <input style="width:200px;" type="text" inputmode="numeric" id="usableArea" name="usableArea"><br>               
        <label for="county">Judet</label><br>    
	      <select style="width:200px;" name="county" id="county" onchange="setCityByCounty()">
	      <option value=""></option>
		    <%for(Map.Entry<String,List<String>> county : countiesCities.entrySet()){ %>
		    <option value="<%=county.getKey()%>"><%=county.getKey()%></option>
		    <%} %>
		  </select><br>
	    <label for="city">Oras</label><br>   	    
	      <select style="width:200px;" name="city" id="city">
		    <%for(String city : citiesAlba){ %>
		    <option value="<%=city%>"><%=city%></option>
		    <%} %>
		  </select><br>
	    <label for="streetName">Strada</label><br>
        <input style="width:200px;" type="text" id="streetName" name="streetName"><br>
        <label for="adressNr">Numar</label><br>
        <input style="width:200px;" type="text" id="adressNr" name="adressNr"><br>        
        <label for="description">Descriere</label><br>
	    <textarea id="description" name="description" rows="4" cols="50" maxlength="600"></textarea><br>
	    <label for="picture">Poza</label><br>
        <input type="file" id="picture" name="picture" accept=".jpg, .jpeg, .png"><br>
	    <label for="category">Categorie</label><br>
        <div class="aa-single-advance-search">
	       <select style="width:200px;" name="category" id="category" onchange="setLabelsForCategory()">
	         <option value="" selected></option>
	         <option value="ApartamentGarsoniera">Apartament-Garsoniera</option>
	         <option value="Casa">Casa</option>
	         <option value="Teren">Teren</option>
	       </select>
	    </div> 	 	    	    
	    <div id="yearDiv" style="display:none;">
		    <br><label for="year">An constructie</label><br>
	        <input type="text" inputmode="numeric" id="year" name="year" maxlength="4"><br>
	    </div>
	    <div id="roomsNrDiv" style="display:none;">
		    <label for="roomsNr">Numar de camere</label><br>
	        <input type="number" id="roomsNr" name="roomsNr" min="0" value="0"><br>
	    </div>	      
        <div id="floorApDiv" style="display:none;">
		    <label for="floorAp">Etaj</label><br>
	        <input type="text" id="floorAp" name="floorAp"><br>
	    </div>
	     <div id="floorsNrHouseDiv" style="display:none;">
	        <label for="floorsNrHouse">Numar de etaje</label><br>
	        <input type="text" id="floorsNrHouse" name="floorsNrHouse"><br>
	    </div><br>
        <div id="paritioningDiv" style="display:none;">
	        <label for="partitioning">Compartimentare</label><br>
	        <div class="aa-single-advance-search">
		       <select style="width:230px" name="partitioning" id="partitioning">
		         <option value="" selected></option>
		         <option value="decomandat">decomandat</option>
		         <option value="semidecomandat">semidecomandat</option>
		         <option value="nedecomandat">nedecomandat</option>
		         <option value="circular">circular</option>
		       </select>
		    </div>
	    </div><br>
        <div class="aa-single-advance-search">
          <input class="aa-search-btn submitButton" type="button" onclick="validateForm()" value="Inregistreaza imobil">
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
<%} }%>