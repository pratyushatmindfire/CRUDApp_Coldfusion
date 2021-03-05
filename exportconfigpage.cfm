<cfif NOT structKeyExists(session, 'loggedInUser')>
	<cflocation url="loginpage.cfm">
</cfif>	

<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Configure Export">
<body>
	<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName# navbarFor="Configure Export">
	<cfmodule template="./customtags/exportconfigcomponent.cfm">
</body>
</html>