<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Login">

	<cfoutput>
		<cfif structKeyExists(session, 'aErrorMessages')>
			<cfset variables.errorsList=session.aErrorMessages/>
		<cfelse>
			<cfset variables.errorsList=ArrayNew(1)/>
		</cfif>
		<cfset variables.isuserLoggedIn=true/>
	</cfoutput>

	<cfdump var=#session#>
	
<!--- 	<cfif structkeyexists(URL, 'logout')>
		<cfscript>
		WriteOutput('
		<script language="JavaScript">
			
		</script>');
		</cfscript>
		<cfinvoke component="MyServices.authentication" method="doLogout" returnvariable="isuserLoggedIn">
		</cfinvoke>
	</cfif> --->


	<!--- <cfif structKeyExists(Form, 'loginButton')>

		<cfset authenticationService=createObject("component","MyServices.authentication")/>
		<cfscript>
			authenticationService.validateUser(Form.name, Form.password);
		</cfscript>
		<cfset variables.errorsList=session.aErrorMessages />

		<cfif ArrayisEmpty(errorsList)>
		
			<cfset variables.isUserLoggedIn = authenticationService.doLogin(Form.name, Form.password)/>
		</cfif>
	</cfif> --->


<body>
	<!-- User has logged in -->
	<cfdump var=#errorsList#/>
	<cfdump var=#Form#/>
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfif structkeyexists(session, 'editMemory')>
			<cflocation url="editpage.cfm?codetoEdit=#session.editMemory.editId#">

		<cfelseif structkeyexists(session, 'deleteMemory')>
			<cflocation url="confirmdelete.cfm?codetoDelete=#session.deleteMemory.deleteId#">

		<cfelseif structkeyexists(session, 'viewMemory')>
			<cflocation url="view.cfm?codetoView=#session.viewMemory.viewId#">

		<cfelse>
			<cflocation url="dashboard.cfm">
		</cfif>
	</cfif>

	<!--- Show login if user isnt logged in --->
	<cfif isuserLoggedIn EQ false OR NOT structKeyExists(Form, 'loginButton') OR NOT ArrayIsEmpty(errorsList)>
		<cfmodule template="./customtags/logincomponent.cfm" errorMessages=#variables.errorsList# userMissing="#NOT variables.isuserLoggedIn#" headingLine="Login">
	</cfif>
	<!--- <cfdump var="#Session#"> --->

	<!--- <cfdump var="#errorsList#"> --->

</body>
</html>