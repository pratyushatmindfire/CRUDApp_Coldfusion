<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Product doesnt exist">

<body>
	<!-- Show view form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName# navbarFor="Product doesnt exist">
	</cfif>
	<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="THIS PRODUCT DOESN'T EXIST">

</body>
</html>