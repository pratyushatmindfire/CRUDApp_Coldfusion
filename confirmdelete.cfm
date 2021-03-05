<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Confirm Delete">
<cfif session.loggedInUser.role EQ 'admin'>
	<body onload="loadDeleteComponentData(<cfoutput>'#url.codetoDelete#'</cfoutput>);">
	<!-- Show confirm delete form if user is logged in -->
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName# navbarFor="Confirm Delete">
		<cfmodule template="./customtags/deletecomponent.cfm">
	</body>

	<cfelse>
		<cfmodule template="./customtags/fallback.cfm" heading="LIMITED ACCESS" content="PLEASE LOGIN AS ADMIN TO DELETE PRODUCTS">
</cfif>
</html>