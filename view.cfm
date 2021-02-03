<cfmodule template="./customtags/htmlheader.cfm" pagetitle="View Page">

<body onload="loadViewComponentData(<cfoutput>'#url.codetoView#'</cfoutput>);">
	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfcookie name = "viewMemory.viewId" value = "#url.codetoView#">
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show view form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<cfmodule template="./customtags/viewcomponent.cfm">
	</cfif>

</body>
</html>