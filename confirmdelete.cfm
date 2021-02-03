<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Confirm Delete">

<body onload="loadDeleteComponentData(<cfoutput>'#url.codetoDelete#'</cfoutput>);">
	<!--- <cfdump var="#Session#"> --->
	
	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<!--- <cfset session.deleteMemory = {'deleteId'= url.codetoDelete}/> --->
		<cfcookie name = "deleteMemory.deleteId" value = "#url.codetoDelete#">
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show confirm delete form if user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<cfmodule template="./customtags/deletecomponent.cfm">
	</cfif>

</body>
</html>