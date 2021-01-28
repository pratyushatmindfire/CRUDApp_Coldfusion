<cfoutput>
	<div class="container eachItem">
    					<div class="itemheader">
    						<p>#attributes.productCode_param#</p>
    					</div>
    					<div class="itemname">
    						<p>#attributes.productName_param#</p>
    					</div>

    					<div class="makechanges">
    						<button class="button leftcurve" value="View" id="#attributes.productCode_param#" onclick="window.location = '/CRUDApp/view.cfm?codetoView=' + this.id;">View
							<button class="button" value="Edit" id="#attributes.productCode_param#" onclick="window.location = '/CRUDApp/editpage.cfm?codetoEdit=' + this.id;">Edit
							<button class="button rightcurve" value="Delete" id="#attributes.productCode_param#" onclick="window.location = '/CRUDApp/confirmdelete.cfm?codetoDelete=' + this.id;"">Delete
    					</div>
    				</div>
</cfoutput>