<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Edit Page">
<cfif session.loggedInUser.role EQ 'admin'>
	<body onload="loadEditComponentData(<cfoutput>'#url.codetoEdit#'</cfoutput>);">
	<!-- Show edit form is user is logged in -->
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<cfmodule template="./customtags/editcomponent.cfm">
	</body>

	<cfelse>
		<cfmodule template="./customtags/fallback.cfm" heading="LIMITED ACCESS" content="PLEASE LOGIN AS ADMIN TO EDIT INFORMATION">

</cfif>
</html>