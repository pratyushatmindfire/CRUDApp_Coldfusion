<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Sessions</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="./js/controller.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

<link rel="stylesheet" href="./css/appstyler.css">

</head>

<cfif structKeyExists(Form, 'loginButton')>

		<cfset authenticationService=createObject("component","MyServices.authentication")/>
		<cfset errorMessages=authenticationService.validateUser(Form.name, Form.password) />

		<cfif ArrayisEmpty(errorMessages)>
		<!-- Proceed to login -->
			<cfset isUserLoggedIn = authenticationService.doLogin(Form.name, Form.password)/>
		</cfif>
	</cfif>

<body>
<!--- 	<cfdump var="#Session#"> --->
	<!-- Show edit form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/header.cfm" userName=#session.loggedInUser.userName#>
		<!-- Query out list of products -->
		<cfquery datasource="classicmodels" name="searchProduct" result="productFound">
			SELECT productCode, productName, productDesc 
			FROM myproducts 
			WHERE productCode=<cfqueryparam value = "#url.codetoView#" cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfoutput query="searchProduct">
			<cfset p_code=#productCode#>
			<cfset p_name=#productName#>
			<cfset p_desc=#productDesc#>
		</cfoutput>

<!--- 		<cfdump var="#p_code#">
		<cfdump var="#p_name#">
		<cfdump var="#p_desc#"> --->



		<h1 id="actionheader">View Page</h1>

		<div class="formcontainer" style="height:50%">

		<h1 class="heading">Viewing product <cfoutput>#p_code#</cfoutput></h1>

		<form class="form-content" name="editform" method="post" action="loginpage.cfm">
			<div class="formfield productname">
				<h3 class="view-header"><cfoutput>#p_name#</cfoutput></h3>
			</div>
			
			<div class="formfield productdescription">
				<h3 class="view-header" style="color: #817a98"><cfoutput>#p_desc#</cfoutput></h3>
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" name="backbutton" value="Go to Dashboard">
			</div>
		</form>
	</div>

	<!--- <cfdump var=#Form#> --->

	</cfif>


	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<div class="formcontainer">

		<h1 class="heading">Login Page</h1>

		<form class="form-content" name="loginform" method="post">
			<div class="formfield username">
				<h3 class="formfield-header">Username</h3>
				<input spellcheck="false" autocomplete="off" class="form-input" type="text" name="name" value="">
			</div>
			
			<div class="formfield password">
				<h3 class="formfield-header">Password</h3>
				<input spellcheck="false" autocomplete="off" class="form-input" type="password" name="password" value="">
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" name="loginButton" value="Login" onclick="window.location='/CRUDApp/editpage.cfm?codetoEdit=' + #url.codetoEdit#;">
			</div>
		</form>
	</div>

	<!-- Validation error -->
	<cfif structKeyexists(variables, 'errorMessages') AND NOT ArrayIsEmpty(errorMessages)>
			<cfoutput>
				<cfloop array="#errorMessages#" item="message">
					<p class="validatormessage">#message#</p>
				</cfloop>
			</cfoutput>
	</cfif>

	<!-- Unable to log in user -->
	<cfif structkeyexists(variables, 'isUserLoggedIn') AND isuserLoggedIn EQ false>
			<p class="validatormessage">User not found. Try again</p>
		</cfif>
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>