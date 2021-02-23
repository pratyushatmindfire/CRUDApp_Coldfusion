<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Login">

	<cfoutput>
		<cfif structKeyExists(session, 'aErrorMessages')>
			<cfset variables.errorsList=session.aErrorMessages/>
		<cfelse>
			<cfset variables.errorsList=ArrayNew(1)/>
		</cfif>
	</cfoutput>

	
<body>
	<!-- User has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfif structkeyexists(cookie, 'editMemory.editId')>
			<cflocation url="editpage.cfm?codetoEdit=#cookie.editMemory.editId#">

		<cfelseif structkeyexists(cookie, 'deleteMemory.deleteId')>
			<cflocation url="confirmdelete.cfm?codetoDelete=#cookie.deleteMemory.deleteId#">

		<cfelseif structkeyexists(cookie, 'viewMemory.viewId')>
			<cflocation url="view.cfm?codetoView=#cookie.viewMemory.viewId#">

		<cfelse>
			<cflocation url="dashboard.cfm">
		</cfif>
	</cfif>

	<!--- Show login if user isnt logged in --->
	<cfif isuserLoggedIn EQ false OR NOT structKeyExists(Form, 'loginButton') OR NOT ArrayIsEmpty(errorsList)>
		<cfmodule template="./customtags/logincomponent.cfm" errorMessages=#variables.errorsList# headingLine="Login">
	</cfif>
</body>
</html>