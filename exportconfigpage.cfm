<cfif NOT structKeyExists(session, 'loggedInUser')>
	<cflocation url="loginpage.cfm">
</cfif>	

<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Configure Export">
<body>
	<cfmodule template="./customtags/exportconfigcomponent.cfm">
</body>
</html>