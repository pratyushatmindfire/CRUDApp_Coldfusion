<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Login">

	<cfoutput>
		<cfset variables.errorsList=ArrayNew(1)/>
		<cfset variables.isuserLoggedIn=true/>
	</cfoutput>
	
	<cfif structkeyexists(URL, 'logout')>
		<cfinvoke component="MyServices.authentication" method="doLogout" returnvariable="isuserLoggedIn">
		</cfinvoke>
		<cflocation url = "loginpage.cfm">
	</cfif>


	<cfif structKeyExists(Form, 'loginButton')>

		<cfset authenticationService=createObject("component","MyServices.authentication")/>
		<cfset variables.errorsList=authenticationService.validateUser(Form.name, Form.password) />

		<cfif ArrayisEmpty(errorsList)>
		<!-- Proceed to login -->
			<cfset variables.isUserLoggedIn = authenticationService.doLogin(Form.name, Form.password)/>
		</cfif>
	</cfif>


<body>
	<!-- User has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfif structkeyexists(Application, 'editMemory')>
			<cflocation url="editpage.cfm?codetoEdit=#Application.editMemory.editId#">

		<cfelseif structkeyexists(Application, 'deleteMemory')>
			<cflocation url="confirmdelete.cfm?codetoDelete=#Application.deleteMemory.deleteId#">

		<cfelseif structkeyexists(Application, 'viewMemory')>
			<cflocation url="view.cfm?codetoView=#Application.viewMemory.viewId#">

		<cfelse>
			<cflocation url="dashboard.cfm">
		</cfif>
	</cfif>

	<!--- <cfdump var="#Form#"> --->
	<!--- Show login if user isnt logged in --->
	<cfif isuserLoggedIn EQ false OR NOT structKeyExists(Form, 'loginButton') OR NOT ArrayIsEmpty(errorsList)>
		<cfmodule template="./customtags/logincomponent.cfm" errorMessages=#variables.errorsList# userMissing="#NOT variables.isuserLoggedIn#" headingLine="Login">
	</cfif>
	<!--- <cfdump var="#Session#"> --->

	<!--- <cfdump var="#errorsList#"> --->

</body>
</html>