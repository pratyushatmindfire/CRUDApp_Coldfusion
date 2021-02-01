<cfcomponent output="true">
	<!--- 
	Delete a product from database based on its product code

	Input :
	productCodetoDelete: A string type argument, which is the product identification code
	
	Output:
	A boolean, which gives the status of delete query	
	--->
	<cffunction name="deleteItembyCode" access="remote" returnType="boolean">
		<cfargument name="productCodetoDelete" required="true" type="string">

		<cftry>
		<cfquery name="deleteProduct">
				DELETE FROM myproducts
				WHERE productCode = <cfqueryparam value = "#productCodetoDelete#" cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfcatch type="any">
			<!--- <cflog log="Application" file="appexceptionLog" text="Whatever you want to log." type="error" > --->
			<cfreturn false/>
		</cfcatch>
		</cftry>

		<cfreturn true/>
	</cffunction>


	<!--- 
	Edit a product from database based on its product code

	Input :
	productCodetoDelete: A string type argument, which is the product identification code
	newproductname: A string type argument, which is the product's new name
	newproductdesc: A string type argument, which is the product's new description
	
	Output:
	A boolean, which gives the status of delete query	
	--->
	<cffunction name="editItembyCode" access="remote" returnType="boolean">
		<cfargument name="productCodetoEdit" required="true" type="string">
		<cfargument name="newproductname" required="true" type="string">
		<cfargument name="newproductdesc" required="true" type="string">


		<cftry>
		<cfquery name="editProduct">
				UPDATE myproducts
				SET productName = <cfqueryparam value = "#newproductname#" cfsqltype = "cf_sql_varchar">, 
				productDesc = <cfqueryparam value = "#newproductdesc#" cfsqltype = "cf_sql_varchar">
				WHERE productCode = <cfqueryparam value = "#productCodetoEdit#" cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfcatch type="any">
			<!--- <cflog log="Application" file="myapplog"
			text="Exception error -- Template: #error.template#"> --->

					<cfreturn false/>
		</cfcatch>
		</cftry>

		<cfreturn true/>
	</cffunction>

	<!--- 
	Fetch a product from database based on its product code

	Input :
	productCodetoDelete: A string type argument, which is the product identification code
	
	Output:
	A query, which gives the details of the product that matches the product ID	
	--->
	<cffunction name="getProductbyId" returntype="query">
		<cfargument name="productCodetoSearch" required="true" type="string">

		<cfquery name="getSingleProduct">
			SELECT productCode, productName, productDesc 
			FROM myproducts
			WHERE productCode = <cfqueryparam value = "#arguments.productCodetoSearch#" cfsqltype="cf_sql_varchar">;
    	</cfquery>

  		<cfreturn getSingleProduct/>
	</cffunction>


	<cffunction name="getAllProducts" access="remote" returntype="query" returnFormat="JSON">

		<cfquery name="allProducts">
			SELECT productCode, productName FROM myproducts;
    	</cfquery>

  		<cfreturn allProducts/>
	</cffunction>



	<cffunction name="createNewItem" access="remote" returntype="boolean">
		<cfargument name="productCodetoCreate" required="true" type="string">
		<cfargument name="productNametoCreate" required="true" type="string">
		<cfargument name="productDesctoCreate" required="true" type="string">

		<cfset Application.createErrors=ArrayNew(1)/>

		<cfif arguments.productCodetoCreate.trim() EQ '' OR arguments.productNametoCreate.trim() EQ '' OR arguments.productDesctoCreate.trim() EQ ''>
			<cfset arrayAppend(Application.createErrors,'Make sure to fill up all the fields') />
		</cfif>

		<!--- Check if product with that code already exists, return false if it does --->
		<cfquery name="checkExistence" result="existence">
			SELECT productCode FROM myproducts
			WHERE productCode = <cfqueryparam value = #arguments.productCodetoCreate# cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfif existence.recordcount NEQ 0 AND arguments.productCodetoCreate NEQ ''>
			<cfset arrayAppend(Application.createErrors,'Product with this ID already exists') />
		</cfif> 

		
		<cfif existence.recordcount EQ 0 AND arrayLen(Application.createErrors) EQ 0>
			<cfquery name="insertNewProduct">
				INSERT INTO myproducts (productCode, productName, productDesc)
				VALUES 
				(
					<cfqueryparam value = "#Trim(arguments.productCodetoCreate)#" cfsqltype = "cf_sql_varchar">,
					<cfqueryparam value = "#Trim(arguments.productNametoCreate)#" cfsqltype = "cf_sql_varchar">,
					<cfqueryparam value = "#Trim(arguments.productDesctoCreate)#" cfsqltype = "cf_sql_varchar">
				);
			</cfquery>
		</cfif>

		<cfif ArrayLen(Application.createErrors) EQ 0>
			<cfreturn true/>
		</cfif>
		
  		<cfreturn false />
	</cffunction>

</cfcomponent>