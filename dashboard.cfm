<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Dashboard">

<body onload="seedDashboard();">

	<cfset StructDelete(Application, 'editMemory', true)/>
	<cfset StructDelete(Application, 'deleteMemory', true)/>
	<cfset StructDelete(Application, 'viewMemory', true)/>

	<!--- Redirect to login if user has not logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show dashboard if user has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>

		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName#>

		<h1 id="actionheader">List of Products</h1>
		<div class="row" id="dashboardcontent">
		</div>
	</cfif>

</body>
</html>