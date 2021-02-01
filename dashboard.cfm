<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Dashboard">

<body onload="seedDashboard();">
	
	<cfset StructDelete(Application, 'editMemory', true)/>
	<cfset StructDelete(Application, 'deleteMemory', true)/>
	<cfset StructDelete(Application, 'viewMemory', true)/>

	<!-- User has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>
		<!--- <cfdump var="#Session#"> --->
		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>

		<h1 id="actionheader">List of Products</h1>

		  	<div class="row" id="dashboardcontent">
		  	</div>

		<cfelse>
			<cflocation url="loginpage.cfm">
	</cfif>

</body>
</html>