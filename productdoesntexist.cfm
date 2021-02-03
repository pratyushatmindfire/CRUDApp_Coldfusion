<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Product doesnt exist">

<body>
	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfset Application.viewMemory = {'viewId'= url.codetoView}/>
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show view form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="THIS PRODUCT DOESN'T EXIST">
	</cfif>

</body>
</html>