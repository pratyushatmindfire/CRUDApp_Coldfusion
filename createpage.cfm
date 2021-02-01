<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Create Page">

<body>

	
	<!--- <cfdump var="#Session#"> --->
	<!-- Show edit form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<!--- <cfdump var="#Session#"> --->
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<h1 id="actionheader">Create Page</h1>

		<!--- Display create component --->
		<cfmodule template="./customtags/createcomponent.cfm" >
	</cfif>


	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>