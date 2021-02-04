<cfcomponent output="false" displayname="exportServiceComponent" extends="loggerService">
	<!--- 
	Generate a PDF file for existing products data
	Dependent on getAllProducts function of crudservices
	--->
	<cffunction name="exporttoPDF" output="true" access="remote">

		<cftry>
		<cfset local.allProducts = CreateObject("Component", "crudservices" ).getAllProducts()>
		<cfheader name="Content-Disposition" value="attachment; filename=exportDataPDF_#TimeFormat(Now())#.pdf">
		<cfcontent type="application/pdf">
		<cfdocument format="PDF">
			<h1 style="text-align: center; font-family: sans-serif">Exported Data</h1>
			<div class="container" style="text-align: center">
			<table border="1">
				<tr style="background: black; color: white;">
					<td style="text-align: center; font-family: sans-serif">Product ID</td>
					<td style="text-align: center; font-family: sans-serif">Product Name</td>
					<td style="text-align: center; font-family: sans-serif">Product Description</td>
				</tr>

				<cfoutput query="allProducts">
					<tr>
						<td style="text-align: center; font-family: sans-serif">#local.allProducts.PRODUCTCODE#</td>
						<td style="text-align: center; font-family: sans-serif">#local.allProducts.PRODUCTNAME#</td>
						<td style="text-align: center; font-family: sans-serif">#local.allProducts.PRODUCTDESC#</td>
					</tr>
				</cfoutput>
			</table>
			</div>
		</cfdocument>

		<cfcatch type="any">
			<cfset var loggerInstance = Super.exceptionLogger(#cfcatch.type#, #cfcatch.message#, #cfcatch.detail#)>
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
	</cffunction>

	<!--- 
	Generate an xls file for existing products data
	Dependent on getAllProducts function of crudservices
	--->
	<cffunction name="exporttoExcel" output="true" access="remote">
		<cftry>
		<cfset local.allProducts = CreateObject("Component", "crudservices" ).getAllProducts()>
		
		<cfset newSheet = spreadsheetNew()>
		<cfset spreadsheetAddRow(newSheet, "ID, Name, Description")>
		<cfset spreadsheetFormatRow(newSheet,{bold=true, fgcolor="lemon_chiffon", fontsize=16}, 1)>
		<cfset spreadsheetAddRows(newSheet, local.allProducts)>	

		<cfheader name="content-disposition" value="attachment; filename=exportDataExcel_#TimeFormat(Now())#.xls">
		<cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(newSheet)#" reset="true">
		<cfcatch type="any">
			<cfset var loggerInstance = Super.exceptionLogger(#cfcatch.type#, #cfcatch.message#, #cfcatch.detail#)>
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>