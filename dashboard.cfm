<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Sessions</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="./js/controller.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<link rel="stylesheet" href="./css/appstyler.css">

</head>

<body>
	
	<cfset StructDelete(Application, 'editMemory', true)/>
	<cfset StructDelete(Application, 'deleteMemory', true)/>

	<!-- User has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<!--- <cfdump var="#Session#"> --->
		<cfmodule template="./customtags/header.cfm" userName=#session.loggedInUser.userName#>

		<h1 id="actionheader">List of Products</h1>


			<cfset queryProducts=createObject("component","MyServices.crudservices").getAllProducts()/>
  			<div class="row">
  				<cftry>
  				<cfoutput query="queryProducts">
    			<div class="col-sm-12 col-md-6 col-lg-4 dynamic-gridbox">
    				<cfmodule template="./customtags/eachItem.cfm" productCode_param=#productCode# productName_param=#queryProducts.productName#>					
    			</div>
    			</cfoutput>

    			<cfcatch type="any">
					<cflocation url="somethingwentwrong.cfm">
				</cfcatch>
				</cftry>
		  </div>

		<cfelse>
			<cflocation url="loginpage.cfm">
	</cfif>

</body>
</html>