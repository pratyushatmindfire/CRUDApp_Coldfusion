<cfoutput>
	<div class="formcontainer" style="height:50%">

		<h1 class="heading">#attributes.heading#</h1>

		<form class="form-content" method="post" action="loginpage.cfm">
			<div class="formfield missing-pageheader">
				<h3 class="view-header">#attributes.content#</h3>
			</div>
			
			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" name="backbutton" value="Go to Dashboard" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">
			</div>
		</form>
	</div>
</cfoutput>