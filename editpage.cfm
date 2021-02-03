<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Edit Page">

<body onload="loadEditComponentData(<cfoutput>'#url.codetoEdit#'</cfoutput>);">
	<!--- Redirect to login if user has not logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
<!--- 		<cfset session.editMemory = {'editId'= url.codetoEdit}/> --->
		<cfcookie name = "editMemory.editId" value = "#url.codetoEdit#">
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show edit form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<cfmodule template="./customtags/editcomponent.cfm">
	</cfif>
</body>
</html>