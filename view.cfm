<cfmodule template="./customtags/htmlheader.cfm" pagetitle="View Page">

<body onload="loadViewComponentData(<cfoutput>'#url.codetoView#'</cfoutput>);">
	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfset session.viewMemory = {'viewId'= url.codetoView}/>
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show view form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfset StructDelete(session, 'viewMemory', true)/>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>
		<cfmodule template="./customtags/viewcomponent.cfm">
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>