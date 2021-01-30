<cfoutput>
	<div class="formcontainer">

		<h1 class="heading">Creating new product</h1>

		<form class="form-content" name="createform">
			<div class="formfield productcode">
				<h3 class="formfield-header">Product Code</h3>
				<input spellcheck="false" required autocomplete="off" class="form-input" type="text" name="new_productcode">
			</div>


			<div class="formfield productname">
				<h3 class="formfield-header">Product Name</h3>
				<input spellcheck="false" required autocomplete="off" class="form-input" type="text" name="new_productname">
			</div>
			
			<div class="formfield productdescription">
				<h3 class="formfield-header">Product Description</h3>
				<input spellcheck="false" required autocomplete="off" class="form-input" type="text" name="new_productdesc">
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="button" name="loginButton" value="Create" onclick="event.preventDefault(); createItem();">
			</div>
		</form>
	</div>
</cfoutput>