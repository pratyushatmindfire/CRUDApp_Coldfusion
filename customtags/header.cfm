<cfoutput>
	<div class="welcomeheader">
		<cfoutput><p class="welcomemessage">Welcome #attributes.userName#</p></cfoutput>
		<div class="add-logout">
		<a class="addbutton" href="createpage.cfm">Create</a>
		<a class="logoutbutton" href="loginpage.cfm?logout">Logout</a>
		</div>
	</div>
</cfoutput>