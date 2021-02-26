<cfoutput>
	<div class="welcomeheader">
		<cfoutput><p class="welcomemessage">Welcome #attributes.userName#</p></cfoutput>
		<div class="add-logout">

		<select class="exportOptionsbutton" name="exportOptions" onchange="exportData(value);">
			<option value="none" selected disabled hidden> Export data </option> 
  			<option value="PDF">Export as PDF</option>
  			<option value="Excel">Export as Excel Sheet</option>
		</select>
		
		<cfif session.loggedInUser.role EQ 'admin'>
			<a class="verifybutton" href="verifyproducts.cfm">Verify</a>
		</cfif>
		<a class="addbutton" href="createpage.cfm">Create</a>
		<a class="logoutbutton" onclick="logoutUser();">Logout</a>
		</div>
	</div>
</cfoutput>