<cfoutput>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>#attributes.pagetitle#</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="./js/controller.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="./css/appstyler.css">

</head>

<cfif attributes.pagetitle EQ "View Page">
	<cfif NOT structKeyExists(url, 'codetoView')>
		<cflocation url="dashboard.cfm">
	</cfif>

	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfcookie name = "viewMemory.viewId" value = "#url.codetoView#">
		<cflocation url="loginpage.cfm">
	</cfif>
</cfif>

<cfif attributes.pagetitle EQ "Edit Page">
	<cfif NOT structKeyExists(url, 'codetoEdit')>
		<cflocation url="dashboard.cfm">
	</cfif>

	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfcookie name = "editMemory.editId" value = "#url.codetoEdit#">
		<cflocation url="loginpage.cfm">
	</cfif>
</cfif>

<cfif attributes.pagetitle EQ "Confirm Delete">
	<cfif NOT structKeyExists(url, 'codetoDelete')>
		<cflocation url="dashboard.cfm">
	</cfif>

	<cfif NOT structKeyExists(session, 'loggedInUser')>
		<cfcookie name = "deleteMemory.deleteId" value = "#url.codetoDelete#">
		<cflocation url="loginpage.cfm">
	</cfif>
</cfif>

</cfoutput>