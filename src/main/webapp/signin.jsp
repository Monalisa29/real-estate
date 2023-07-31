<%@page import="java.util.Objects"%>
<%
String signinFromPage = (String) session.getAttribute("signinFromPage");
String errorMessage = request.getParameter("mess");
String email = request.getParameter("e");
%>
<%@page import="helper.UserAccountHelper"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>HomeStor | Conectare</title>
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
<link rel="stylesheet" href="css/jquery.fancybox.css" type="text/css"
	media="screen" />
<!-- Theme color -->
<link id="switcher" href="css/theme-color/default-theme.css"
	rel="stylesheet">
<!-- Main style sheet -->
<link href="css/style.css" rel="stylesheet">
<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Vollkorn'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css'>
<style>
	.aa-search-btn{
		background-color:#59abe3; 
		color:#fff; 
		padding:13px 26px; 
		border:none; 
		font-weight:bold;"
	}
	.errorMessage{
		color: red;
	}
</style>
<script>
	function validateForm()
	{
		var email = document.getElementById("email").value;
		var password = document.getElementById("password").value;
		
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
		document.singinForm.submit();
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
								<h4>Conecteaza-te</h4>
							</div>
							<form class="contactform" name="singinForm" id="singinForm" action="verifySigninData.jsp" method="GET">
							<%if(!Objects.isNull(errorMessage)){%><p class="errorMessage"><%=errorMessage %></p><%} %>
								<div class="aa-single-field">
									<label for="email">Email <span class="required">*</span></label>
									<input type="email" name="email" id="email" <%if(!Objects.isNull(email)){%>value="<%=email%>"<%} %>>
								</div>
								<div class="aa-single-field">
									<label for="password">Parola <span class="required">*</span></label>
									<input type="password" name="password" id="password">
								</div>
								<div class="aa-single-field"></div>
								<div class="aa-single-submit">
									<input type="button" value="Conectare" class="aa-search-btn" onclick="validateForm()">
									<p>Nu Ai Inca Un Cont? <a href="register.jsp">Creeaza unul!</a></p>
								</div>
								<%if(!Objects.isNull(signinFromPage) && "addFav".equals(signinFromPage)){
									String propertiesDetailLink = (String) session.getAttribute("propertiesDetailLink");%>							    
									<a href="properties_detail.jsp<%=propertiesDetailLink%>">Renunta</a>
								<%}else{%>
									<a href="index.jsp">Renunta</a>
								<%} %>							
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