<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Verify Products">

	<!--- Redirect to login if user has not logged in --->
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>

	<!--- Load verifyproducts module is user is logged in and is not a client --->
	<cfif structKeyExists(session, 'loggedInUser')>
		<cfif session.loggedInUser.role EQ 'admin'>
			<body onload="seedVerifyPanel();">
			<div id="verifyPanel">
				
			</div>
			</body>

		<cfelse>
			<cfmodule template="./customtags/fallback.cfm" heading="LIMITED ACCESS" content="ONLY AN ADMIN CAN VERIFY PRODUCT">
		</cfif>
	</cfif>
</html>