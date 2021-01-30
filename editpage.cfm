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

<body>
	<!--- <cfdump var="#Session#"> --->
	<!-- Show edit form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<!--- <cfdump var="#Session#"> --->
		<cfmodule template="./customtags/header.cfm" userName=#session.loggedInUser.userName#>
		<h1 id="actionheader">Edit Page</h1>

		<!-- Query out list of products -->
		<cfset querySingleProduct=createObject("component","MyServices.crudservices").getProductbyId(url.codetoEdit)/>

		<cfif variables.querySingleProduct.recordcount EQ 0>

			<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="THIS PRODUCT DOESN'T EXIST">

		<cfelse>
		<cftry>
		<cfoutput query="querySingleProduct">
			<cfmodule template="./customtags/editcomponent.cfm" productCode_param=#querySingleProduct.productCode# productName_param=#querySingleProduct.productName# productDesc_param=#querySingleProduct.productDesc# >
		</cfoutput>

		<cfcatch type="any">
			<cflocation url="somethingwentwrong.cfm">
		</cfcatch>
		</cftry>

		</cfif>

	<!--- <cfdump var=#Form#> --->

	</cfif>


	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfset Application.editMemory = {'editId'= url.codetoEdit}/>
		<cflocation url="loginpage.cfm">
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>