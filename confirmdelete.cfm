<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Confirm Delete">

<body onload="loadDeleteComponentData(<cfoutput>'#url.codetoDelete#'</cfoutput>);">
	<!-- Show confirm delete form if user is logged in -->
	<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
	<cfmodule template="./customtags/deletecomponent.cfm">

</body>
</html>