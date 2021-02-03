<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Export Excel Sheet</title>
</head>

<body>
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>

	
	<cfobject name="myExportservices" type="component" component="services/exportservices">
	<cfoutput>
	<cfset myExportservices.exporttoExcel()/>
	</cfoutput>
</body>
</html>