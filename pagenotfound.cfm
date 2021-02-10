<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Page not found">

<body>

	<!-- Show missing template compoennt if user is logged in and has requested something that wasnt found -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
	</cfif>

	<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="THIS PAGE DOESN'T EXIST">
</body>
</html>