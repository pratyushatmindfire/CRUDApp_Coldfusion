<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Dashboard">
<!--- <cfdump var =#session#/> --->
<body onload="seedDashboard();">

	<cfset StructDelete(cookie, 'editMemory.editId', true)/>
	<cfset StructDelete(cookie, 'deleteMemory.deleteId', true)/>
	<cfset StructDelete(cookie, 'viewMemory.viewId', true)/>

	<!--- Redirect to login if user has not logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>

	<!-- Show dashboard if user has logged in -->
	<cfif structKeyExists(session, 'loggedInUser')>

		<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName# navbarFor="Dashboard">

		<h1 id="actionheader">List of Products</h1>
		<div class="row" id="dashboardcontent">

		</div>
	</cfif>

</body>
</html>