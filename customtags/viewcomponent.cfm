<cfoutput>
	<div class="formcontainer" style="height:50%">

		<h1 class="heading" name="view_productcode"></h1>

		<form class="form-content" name="viewform">
			<div class="formfield productname">
				<h3 class="view-header" name="view_productname"></h3>
			</div>
			
			<div class="formfield productdescription">
				<h3 class="view-header" name="view_productdesc" style="color: rgb(129, 122, 152)"></h3>
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" name="backbutton" value="Go to Dashboard" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">
			</div>
		</form>
	</div>
</cfoutput>