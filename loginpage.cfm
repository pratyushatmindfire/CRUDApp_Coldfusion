<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Sessions</title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="controller.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
</head>

<cfdump var="#Form#">

	<cfif structkeyexists(URL, 'logout')>
		<cfinvoke component="MyServices.authentication" method="doLogout" returnvariable="isuserLoggedIn">
		</cfinvoke>
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
		<p><cfoutput>Welcome #session.loggedInUser.userName#</cfoutput></p>
		<p><a href="loginpage.cfm?logout">Logout</a></p>

		<!-- Query out list of products -->
		<cfquery datasource="classicmodels" name="showProducts" result="allProducts">
			SELECT productCode, productName FROM products;
		</cfquery>

		<h1>List of all products queried</h1>
		<table>
			<tr>
				<td>Product Code</td>
				<td>Product Name</td>
			<tr>

			<cfoutput query="showProducts">
				<tr>
					<td>#productCode#</td>
					<td>#productName#</td>
					<td><button value="View" id="#productCode#">View</td>
					<td><button value="Edit" id="#productCode#">Edit</td>
					<td><button value="Delete" id="#productCode#" onclick="deleteItem(this.id)">Delete</td>
				</tr>
			</cfoutput>
		</table>
	</cfif>

	<cfif isuserLoggedIn EQ false OR NOT structKeyExists(Form, 'loginButton')>
			<div class="container">
		<h1>Login Page</h1>

		<form name="loginform" method="post" action="loginpage.cfm">
			<h3>Username</h3>
			<input type = "text" name="name" value="">

			<h3>Password</h3>
			<input type="password" name="password" value="">

			<input type="submit" name="loginButton" value="Login">
		</form>

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
			<p>User not found. Try again</p>
		</cfif>
	</div>
	</cfif>

	<cfdump var="#Session#">

</body>
</html>


