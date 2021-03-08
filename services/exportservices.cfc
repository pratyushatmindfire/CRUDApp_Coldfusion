<cfcomponent output="false" displayname="exportServiceComponent" extends="loggerService">
	<!--- 
	Generate a PDF file for existing products data
	Dependent on getAllProducts function of crudservices
	--->
	<cffunction name="exportData" output="true" access="remote">

		<cfargument name="exportMode" required="true" type="string">
		<cfargument name="exportsortSubject" required="true" type="string">
		<cfargument name="exportorderSubject" required="true" type="string">
		<cfargument name="exportminPrice" required="true" type="numeric">
		<cfargument name="exportmaxPrice" required="true" type="numeric">

		<cftry>
		<cfset local.exportProducts = CreateObject("Component", "crudservices" ).getFilteredData(arguments.exportsortSubject, arguments.exportorderSubject, arguments.exportminPrice, arguments.exportmaxPrice)>
		<cfdump var="#local.exportProducts#"/>

		<cfif arguments.exportMode EQ 'Excel'>
			<cfset newSheet = spreadsheetNew()>
			<cfset spreadsheetAddRow(newSheet, "ID, Name, Description, Price")>
			<cfset spreadsheetFormatRow(newSheet,{bold=true, fgcolor="lemon_chiffon", fontsize=16}, 1)>
			<cfset spreadsheetAddRows(newSheet, local.exportProducts)>	

			<cfheader name="content-disposition" value="attachment; filename=exportDataExcel_#TimeFormat(Now())#.xls">
			<cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(newSheet)#" reset="true">

		<cfelse>
			<cfheader name="Content-Disposition" value="attachment; filename=exportDataPDF_#TimeFormat(Now())#.pdf">
			<cfcontent type="application/pdf">

			<!--- Reusing the code for preview --->
			<cfset previewExport(arguments.exportMode, arguments.exportsortSubject, arguments.exportorderSubject, arguments.exportminPrice, arguments.exportmaxPrice) />



		</cfif>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
			<!--- <cflocation url="somethingwentwrong.cfm"/> --->
		</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="previewExport" output="true" access="remote">
		<cfargument name="exportMode" required="true" type="string">
		<cfargument name="exportsortSubject" required="true" type="string">
		<cfargument name="exportorderSubject" required="true" type="string">
		<cfargument name="exportminPrice" required="true" type="numeric">
		<cfargument name="exportmaxPrice" required="true" type="numeric">

		<cftry>
		<cfset local.exportProductsPreview = CreateObject("Component", "crudservices" ).getFilteredData(arguments.exportsortSubject, arguments.exportorderSubject, arguments.exportminPrice, arguments.exportmaxPrice)>
		<cfdump var="#local.exportProductsPreview#"/>

		
		
		<cfcontent type="application/pdf">
		<cfdocument format="PDF" pagetype="A4" orientation="portrait">
			<style>
				td
				{
					text-align: center; 
					font-family: sans-serif;
				}

				tr
				{
					background: white; 
					color: black;
				}

				.container
				{
					text-align: center
				}

				h1
				{
					text-align: center; 
					font-family: sans-serif
				}
			</style>
			<h1>Exported Data</h1>
			<div class="container">
			<table border="1">
				<tr>
					<td>Product ID</td>
					<td>Product Name</td>
					<td>Product Description</td>
					<td>Price</td>
				</tr>

				<cfoutput query="exportProductsPreview">
					<tr>
						<td>#exportProductsPreview.PRODUCTCODE#</td>
						<td>#exportProductsPreview.PRODUCTNAME#</td>
						<td>#exportProductsPreview.PRODUCTDESC#</td>
						<td>#exportProductsPreview.PRICE#</td>
					</tr>
				</cfoutput>
			</table>
			</div>
		</cfdocument>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
			<!--- <cflocation url="somethingwentwrong.cfm"/> --->
		</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>