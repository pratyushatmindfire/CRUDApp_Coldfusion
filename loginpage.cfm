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

<!--- <cfdump var="#Form#"> --->

	<cfif structkeyexists(URL, 'logout')>
		<cfinvoke component="MyServices.authentication" method="doLogout" returnvariable="isuserLoggedIn">
		</cfinvoke>
		<cflocation url = "loginpage.cfm">
	</cfif>


	<cfif structKeyExists(Form, 'loginButton')>

		<cfset authenticationService=createObject("component","MyServices.authentication")/>
		<cfset errorMessages=authenticationService.validateUser(Form.name, Form.password) />

		<cfif ArrayisEmpty(errorMessages)>
		<!-- Proceed to login -->
			<cfset isUserLoggedIn = authenticationService.doLogin(Form.name, Form.password)/>
		</cfif>
	</cfif>





<body>
	<!-- User has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<!--- <cfdump var="#Session#"> --->
		<div class="welcomeheader"><cfoutput><p class="welcomemessage">Welcome #session.loggedInUser.userName#</p></cfoutput><a class="logoutbutton" href="loginpage.cfm?logout">Logout</a></div>

		<!-- Query out list of products -->
		<cfquery datasource="classicmodels" name="showProducts" result="allProducts">
			SELECT productCode, productName FROM myproducts;
		</cfquery>

		<h1 id="actionheader">List of Products</h1>

  			<div class="row">
  				<cfoutput query="showProducts">
    			<div class="col-sm-12 col-md-6 col-lg-4 dynamic-gridbox">
    				<div class="container eachItem">
    					<div class="itemheader">
    						<p>#productCode#</p>
    					</div>
    					<div class="itemname">
    						<p>#productName#</p>
    					</div>

    					<div class="makechanges">
    						<button class="button leftcurve" value="View" id="#productCode#" onclick="window.location = '/CRUDApp/view.cfm?codetoView=' + this.id;">View
							<button class="button" value="Edit" id="#productCode#" onclick="window.location = '/CRUDApp/editpage.cfm?codetoEdit=' + this.id;">Edit
							<button class="button rightcurve" value="Delete" id="#productCode#" onclick="deleteItem(this.id)">Delete
    					</div>
    				</div>					
    			</div>
    			</cfoutput>
		</div>
	</cfif>

	<cfif isuserLoggedIn EQ false OR NOT structKeyExists(Form, 'loginButton')>
		<div class="formcontainer">

		<h1 class="heading">Login Page</h1>

		<form class="form-content" name="loginform" method="post" action="loginpage.cfm">
			<div class="formfield username">
				<h3 class="formfield-header">Username</h3>
				<input spellcheck="false" required autocomplete="off" class="form-input" type="text" name="name" value="">
			</div>
			
			<div class="formfield password">
				<h3 class="formfield-header">Password</h3>
				<input spellcheck="false" required autocomplete="off" class="form-input" type="password" name="password" value="">
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" name="loginButton" value="Login">
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
	<cfif structkeyexists(variables, 'isUserLoggedIn') AND isuserLoggedIn EQ false AND NOT structkeyexists(URL, 'logout')>
			<p class="validatormessage">User not found. Try again</p>
		</cfif>
	</cfif>
	<!--- <cfdump var="#Session#"> --->

</body>
</html>