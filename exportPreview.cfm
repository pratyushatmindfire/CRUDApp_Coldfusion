<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Export Preview</title>
</head>

<body>
	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cflocation url="loginpage.cfm">
	</cfif>

	
	<cfobject name="myExportservices" type="component" component="services/exportservices">

	<cfif NOT isdefined('url.exportMode') OR NOT ArrayContains(['PDF', 'Excel'], url.exportMode)>
		<cfset url.exportMode='PDF'/>
	</cfif>

	<cfif NOT isdefined('url.exportsortSubject') OR NOT ArrayContains(['productName', 'price'], url.exportsortSubject)>
		<cfset url.exportsortSubject='productName'/>
	</cfif>

	<cfif NOT isdefined('url.exportorderSubject') OR NOT ArrayContains(['asc', 'desc'], url.exportorderSubject)>
		<cfset url.exportorderSubject='Asc'/>
	</cfif>

	<cfif NOT isdefined('url.exportminPrice') OR NOT IsNumeric(url.exportminPrice)>
		<cfset url.exportminPrice=0/>
	</cfif>

	<cfif NOT isdefined('url.exportmaxPrice') OR NOT IsNumeric(url.exportmaxPrice)>
		<cfset url.exportmaxPrice=100/>
	</cfif>

	<cfdump var="#url#"/>
	<cfdump var="#url.exportMode#"/>
	<cfdump var="#url.exportsortSubject#"/>
	<cfdump var="#url.exportorderSubject#"/>
	<cfdump var="#url.exportminPrice#"/>
	<cfdump var="#url.exportmaxPrice#"/>


	<cfoutput>
	<cfset myExportservices.previewExport(url.exportMode, url.exportsortSubject, url.exportorderSubject, url.exportminPrice, url.exportmaxPrice)/>
	</cfoutput>
</body>
</html>