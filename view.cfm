<cfmodule template="./customtags/htmlheader.cfm" pagetitle="View Page">

<body>
<!--- 	<cfdump var="#Session#"> --->
	<!-- Show edit form is user is logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>

		<cftry>

		<cfset querySingleProduct=createObject("component","MyServices.crudservices").getProductbyId(url.codetoView)/>

		<cfif variables.querySingleProduct.recordcount EQ 0>

			<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="THIS PRODUCT DOESN'T EXIST">

		<cfelse>
			
				<cfoutput query="querySingleProduct">
					<cfmodule template="./customtags/viewcomponent.cfm" productCode_param=#querySingleProduct.productCode# productName_param=#querySingleProduct.productName# productDesc_param=#querySingleProduct.productDesc# >
				</cfoutput>
		</cfif>

				<cfcatch type="any">
					<cflocation url="somethingwentwrong.cfm">
				</cfcatch>
				
		</cftry>

		

	</cfif>


	<!--- Show login form if user isnt logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfset Application.viewMemory = {'viewId'= url.codetoView}/>
		<cflocation url="loginpage.cfm">
	</cfif>
	<!--- <cfdump var="#Form#"> --->

</body>
</html>