<cfoutput>
	<div class="formcontainer">

		<h1 class="heading" name="edit_productcode"></h1>

		<form class="form-content" name="editform">
			<div class="formfield productname">
				<h3 class="formfield-header">Product Name</h3>
				<input name="edit_productname" spellcheck="false" required autocomplete="off" class="form-input" type="text">
			</div>
			
			<div class="formfield productdescription">
				<h3 class="formfield-header">Product Description</h3>
				<input name="edit_productdesc" spellcheck="false" required autocomplete="off" class="form-input" type="text">
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" id='<cfoutput>#url.codetoEdit#</cfoutput>' value="Update" onclick="event.preventDefault(); editItem(this.id)";>

				<input class="form-submit" type="button" value="Back to Dashboard" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">
			</div>
		</form>
	</div>
</cfoutput>