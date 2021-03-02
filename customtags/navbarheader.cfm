<cfoutput>
	<div class="welcomeheader">
		<cfoutput><p class="welcomemessage">Welcome #attributes.userName#</p></cfoutput>
		<div class="add-logout">

		<a class="exportOptionsbutton" href="exportconfigpage.cfm">Export</a>
		
		<cfif session.loggedInUser.role EQ 'admin'>
			<a class="verifybutton" href="verifyproducts.cfm">Verify</a>
		</cfif>
		<a class="addbutton" href="createpage.cfm">Create</a>
		<a class="logoutbutton" onclick="logoutUser();">Logout</a>
		</div>
	</div>
</cfoutput>