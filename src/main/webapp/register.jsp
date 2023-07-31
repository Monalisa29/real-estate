<%@page import="java.util.Objects"%>
<%
String messInsert = request.getParameter("mess");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>HomeStor | Inregistrare</title>
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
    .aa-search-btn{
		background-color:#59abe3; 
		color:#fff; 
		padding:13px 26px; 
		border:none; 
		font-weight:bold;"
	}
    </style>
    <script>
    function validateForm(){
    	var fname = document.getElementById("fname").value;
    	var lname = document.getElementById("lname").value;
    	var cnp = document.getElementById("cnp").value;
    	var email = document.getElementById("email").value;
    	var password = document.getElementById("password").value;
    	var confirmPassword = document.getElementById("confirm-password").value;
    	var sexRB = document.getElementsByName("sex");
	  	var selectedSex = "";
	  	for (i = 0; i < sexRB.length; i++) {
	         if (sexRB[i].checked)
	         {
	           selectedSex = sexRB[i].value;
	         }
	    }
	  	var phoneNr = document.getElementById("phoneNr").value;
    	
    	if(fname == ""){
   		   alert("Campul 'Nume' este obligatoriu!");
   		   return false;
   	   }
    	else if(!/^[a-zA-Z]+(\s[a-zA-Z]+)?$/.test(fname)){
   		   alert("Numele trebuie sa contina doar litere");
     	   return false;	
    	}
    	else if(lname == ""){
   		   alert("Campul 'Prenume' este obligatoriu!");
      	   return false;
      	}
    	else if(!/^[a-zA-Z]+(\s[a-zA-Z]+)?$/.test(lname)){
    	   alert("Numele trebuie sa contina doar litere");
      	   return false;	
     	}
    	else if(cnp == ""){
     	   alert("Campul 'CNP' este obligatoriu!");
           return false;
         }
    	else if(cnp.length != 13 || !/^[0-9]+$/.test(cnp)){
      	   alert("Campul 'CNP' trebuie sa contina 13 cifre!");
           return false;
        }
    	else if(selectedSex == ""){
    	   alert("Campul 'Sex' este obligatoriu!");
    	   return false;
    	}
    	else if(phoneNr == ""){
     	   alert("Campul 'Numar de telefon' este obligatoriu!");
           return false;
        }
    	else if(!/^[0-9]+$/.test(phoneNr)){
       	   alert("Campul 'Numar de telefon' trebuie sa contina doar cifre!");
           return false;
        }
    	else if(email == ""){
     	   alert("Campul 'Email' este obligatoriu!");
           return false;
        }
    	else if(!email.endsWith("@yahoo.com") && !email.endsWith("@gmail.com")){
    		alert("Emailul trebuie sa fie de forma 'nume@yahoo.com' sau 'nume@gmail.com'!");
    		return false;
    	}
    	else if(password == ""){
    	   alert("Campul 'Parola' este obligatoriu!");
  		   return false;
       	}
    	else if(confirmPassword == ""){
     	   alert("Campul 'Confirma Parola' este obligatoriu!");
   		   return false;
        }
    	else if(password != confirmPassword){
    		alert("Campurile 'Parola' si 'Confirma parola' nu sunt egale");
    		return false;
    	}
    	document.registerForm.submit();
    }
    </script>
  </head>
  <body>   
  <section id="aa-signin">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-signin-area">
            <div class="aa-signin-form">
              <div class="aa-signin-form-title">              
                <a class="aa-property-home" href="index.jsp">HomeStor</a>
                <h4>Creaza-ti un cont si ramai cu noi</h4>
              </div>
              <%if(!Objects.isNull(messInsert) && messInsert.equals("1")){ %>
	              <p style="color:green;">Contul a fost creat cu succes.</p>
	            <%} 
              else if(!Objects.isNull(messInsert) && messInsert.equals("0")){%>
              <p style="color:red;">Datele nu au fost completate corespunzator</p>            
              <% }
              else if(!Objects.isNull(messInsert) && messInsert.equals("2")){%>
              <p style="color:red;">Contul nu a putut fi creat. Va rugam incercati mai tarziu.</p>            
              <% }
              else if(!Objects.isNull(messInsert) && messInsert.equals("3")){%>
              <p style="color:red;">Acest email este deja inregistrat</p>            
              <% }%>
              <form name="registerForm" id="registerForm" action="newAccount.jsp" method="POST">                                               
                <div class="aa-single-field">
                  <label for="fname">Nume <span class="required">*</span></label>
                  <input type="text" aria-required="true" name="fname" id="fname">
                </div>
                <div class="aa-single-field">
                  <label for="lname">Prenume <span class="required">*</span></label>
                  <input type="text" aria-required="true" name="lname" id="lname">
                </div>
                <div class="aa-single-field">
                  <label for="cnp">CNP <span class="required">*</span></label>
                  <input type="text" aria-required="true" name="cnp" id="cnp" maxlength="13">
                </div>
                <div class="aa-single-field">
                  <label for="sex">Sex <span class="required">*</span></label><br>
                  <input type="radio" id="M" name="sex" value="M">Masculin<br>
                  <input type="radio" id="F" name="sex" value="F">Feminin
                </div>
                <div class="aa-single-field">
                  <label for="phoneNr">Numar de telefon <span class="required">*</span></label>
                  <input type="text" aria-required="true" name="phoneNr" id="phoneNr">
                </div>
                <div class="aa-single-field">
                  <label for="email">Email <span class="required">*</span></label>
                  <input type="email" aria-required="true" name="email" id="email">
                </div>
                <div class="aa-single-field">
                  <label for="password">Parola <span class="required">*</span></label>
                  <input type="password" name="password" id="password"> 
                </div>
                <div class="aa-single-field">
                  <label for="confirm-password">Confirma Parola <span class="required">*</span></label>
                  <input type="password" name="confirm-password" id="confirm-password"> 
                </div>
                <div class="aa-single-submit">
                  <input type="button" value="Creaza cont" class="aa-search-btn" onclick="validateForm()">
                  <p>Ai Deja Cont? <a href="signin.jsp">Conecteaza-te!</a></p>                    
                </div>                
                <a href="index.jsp">Renunta</a>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section> 
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