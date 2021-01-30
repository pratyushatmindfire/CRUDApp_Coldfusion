<cfoutput>
	<div class="formcontainer" style="height:50%">

		<h1 class="heading">Viewing product <cfoutput>#attributes.productCode_param#</cfoutput></h1>

		<form class="form-content" name="viewform">
			<div class="formfield productname">
				<h3 class="view-header"><cfoutput>#attributes.productName_param#</cfoutput></h3>
			</div>
			
			<div class="formfield productdescription">
				<h3 class="view-header" style="color: rgb(129, 122, 152)"><cfoutput>#attributes.productDesc_param#</cfoutput></h3>
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" name="backbutton" value="Go to Dashboard" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">
			</div>
		</form>
	</div>
</cfoutput>