<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Confirm Delete">

<body>
	<!--- <cfdump var="#Session#"> --->
	<!-- Show edit form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<!--- <cfdump var="#Session#"> --->
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>

		<cfset querySingleProduct=createObject("component","MyServices.crudservices").getProductbyId(url.codetoDelete)/>

		<cfif variables.querySingleProduct.recordcount EQ 0>

			<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="THIS PRODUCT DOESN'T EXIST">

		<cfelse>
			<cftry>
				<cfoutput query="querySingleProduct">
					<cfmodule template="./customtags/deletecomponent.cfm" productCode_param=#productCode# >
				</cfoutput>

				<cfcatch type="any">
					<cflocation url="somethingwentwrong.cfm">
				</cfcatch>
			</cftry>

		</cfif>
	<!--- <cfdump var=#Form#> --->

	</cfif>


	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfset Application.deleteMemory = {'deleteId'= url.codetoDelete}/>
		<cflocation url="loginpage.cfm">
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>