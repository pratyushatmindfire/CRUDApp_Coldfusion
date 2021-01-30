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

	<!-- Show missing template compoennt if user is logged in and has requested something that wasnt found -->
	<cfif structKeyExists(session, 'loggedInUser')>
			<cfmodule template="./customtags/header.cfm" userName=#session.loggedInUser.userName#>
			<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="SOMETHING WENT WRONG">
	</cfif>


	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>