<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Create Page">

<body>
	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show create form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName# navbarFor="Create Page">
		<h1 id="actionheader">Create Page</h1>

		<!--- Display create component --->
		<cfmodule template="./customtags/createcomponent.cfm" >
	</cfif>
</body>
</html>