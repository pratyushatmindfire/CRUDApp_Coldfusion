<cfoutput>
	<div style="height: min-content;" class="formcontainer">

		<h1 class="heading">Deleting a product</h1>

		<form class="form-content" name="editform">
			<div class="formfield productname">
				<h3 class="formfield-header text-center">Click on Yes to delete the product</h3>
				<h2 name="delete_productcode"></h2>
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="button" id='<cfoutput>#url.codetoDelete#</cfoutput>' name="loginButton" value="Yes" onclick="event.preventDefault(); deleteItem(this.id);">

				<input class="form-submit" type="button" value="No" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">
			</div>
		</form>
	</div>
</cfoutput>