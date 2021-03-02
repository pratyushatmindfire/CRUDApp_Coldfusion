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

	<cfif NOT isdefined('url.exportMode')>
		<cfset url.exportMode='PDF'/>
	</cfif>

	<cfif NOT isdefined('url.exportsortSubject')>
		<cfset url.exportsortSubject='productName'/>
	</cfif>

	<cfif NOT isdefined('url.exportorderSubject')>
		<cfset url.exportorderSubject='Asc'/>
	</cfif>

	<cfif NOT isdefined('url.exportminPrice')>
		<cfset url.exportminPrice=0/>
	</cfif>

	<cfif NOT isdefined('url.exportmaxPrice')>
		<cfset url.exportmaxPrice=100/>
	</cfif>

	<cfdump var="#url#"/>
	<cfdump var="#url.exportMode#"/>
	<cfdump var="#url.exportsortSubject#"/>
	<cfdump var="#url.exportorderSubject#"/>
	<cfdump var="#url.exportminPrice#"/>
	<cfdump var="#url.exportmaxPrice#"/>


	<cfoutput>
	<cfset myExportservices.exportData(url.exportMode, url.exportsortSubject, url.exportorderSubject, url.exportminPrice, url.exportmaxPrice)/>
	</cfoutput>
</body>
</html>