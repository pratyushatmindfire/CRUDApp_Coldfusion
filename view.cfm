<cfmodule template="./customtags/htmlheader.cfm" pagetitle="View Page">

<body onload="loadViewComponentData(<cfoutput>'#url.codetoView#'</cfoutput>);">
	<cfmodule template="./customtags/navbarheader.cfm" userName=#session.loggedInUser.userName# navbarFor="View Page">
	<cfmodule template="./customtags/viewcomponent.cfm">
</body>
</html>