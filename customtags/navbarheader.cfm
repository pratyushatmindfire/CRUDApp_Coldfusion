<cfoutput>
	<div class="welcomeheader">
		<cfoutput><p class="welcomemessage">Welcome #attributes.userName#</p></cfoutput>
		<div class="add-logout">

		<cfif attributes.navbarFor NEQ 'Dashboard'>
			<a class="nav-backtodashboard" href="dashboard.cfm">Dashboard</a>
		</cfif>

		<cfif attributes.navbarFor NEQ 'Configure Export'>
			<a class="exportOptionsbutton" href="exportconfigpage.cfm">Export</a>
		</cfif>
		
		<cfif session.loggedInUser.role EQ 'admin' AND attributes.navbarFor NEQ 'Verify Products'>
			<a class="verifybutton" href="verifyproducts.cfm">Verify</a>
		</cfif>

		<cfif attributes.navbarFor NEQ 'Create Page'>
			<a class="addbutton" href="createpage.cfm">Create</a>
		</cfif>

		<a class="logoutbutton" onclick="logoutUser();">Logout</a>
		</div>
	</div>
</cfoutput>