<cfcomponent output="true">
	<cffunction name="exporttoPDF" output="true" access="remote">

		<cftry>
		<cfset allProducts = CreateObject("Component", "crudservices" ).getAllProducts()>
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
						<td style="text-align: center; font-family: sans-serif">#allProducts.PRODUCTCODE#</td>
						<td style="text-align: center; font-family: sans-serif">#allProducts.PRODUCTNAME#</td>
						<td style="text-align: center; font-family: sans-serif">#allProducts.PRODUCTDESC#</td>
					</tr>
				</cfoutput>
			</table>
			</div>
		</cfdocument>

		<cfcatch type="any">
			<cflog file="myAppLog" application="yes" text="Type=#cfcatch.type# Message=#cfcatch.message#">
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
	</cffunction>



	<cffunction name="exporttoExcel" output="true" access="remote">

		<cftry>
		<cfset allProducts = CreateObject("Component", "crudservices" ).getAllProducts()>
		
		<cfheader name="Content-Disposition" value="attachment; filename=exportDataExcel.xls">
		<cfcontent type="application/vnd.ms-excel">
		
		
      	<table border="1">
         		<tr>
            		<td>Product Code</td>
            		<td>Product Name</td>
            		<td>Product Description</td>
         		</tr>
         	<cfoutput query="allProducts">
            	<tr>
               		<td>#allProducts.PRODUCTCODE#</td>
               		<td>#allProducts.PRODUCTNAME#</td>
               		<td>#allProducts.PRODUCTDESC#</td>
            	</tr>
         	</cfoutput>
      	</table>
   		</cfcontent>
		

		<cfcatch type="any">
			<cflog file="myAppLog" application="yes" text="Type=#cfcatch.type# Message=#cfcatch.message#">
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>