<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Edit Page">

<body onload="loadEditComponentData(<cfoutput>'#url.codetoEdit#'</cfoutput>);">
	<!-- Show edit form is user is logged in -->
	<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
	<cfmodule template="./customtags/editcomponent.cfm">
</body>
</html>