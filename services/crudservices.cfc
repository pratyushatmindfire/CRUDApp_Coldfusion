<cfcomponent output="true" displayname="crudServiceComponent" extends="loggerService">
	<!--- 
	Delete a product from database based on its product code

	Input :
	productCodetoDelete: A string type argument, which is the product identification code
	
	Output:
	A boolean, which gives the status of delete query	
	--->
	<cffunction name="deleteItembyCode" access="remote" returnType="boolean" returnFormat="JSON">
		<cfargument name="productCodetoDelete" required="true" type="string">

		<cftry>
		<cfquery name="deleteProduct">
				DELETE FROM myproducts
				WHERE productCode = <cfqueryparam value = "#arguments.productCodetoDelete#" cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
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
	<cffunction name="editItembyCode" access="remote" returnType="boolean" returnFormat="JSON">
		<cfargument name="productCodetoEdit" required="true" type="string">
		<cfargument name="newproductname" required="true" type="string">
		<cfargument name="newproductdesc" required="true" type="string">


		<cftry>
		<cfquery name="editProduct">
				UPDATE myproducts
				SET productName = <cfqueryparam value = "#arguments.newproductname#" cfsqltype = "cf_sql_varchar">, 
				productDesc = <cfqueryparam value = "#arguments.newproductdesc#" cfsqltype = "cf_sql_varchar">
				WHERE productCode = <cfqueryparam value = "#arguments.productCodetoEdit#" cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
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
	<cffunction name="getProductbyId" access="remote" returntype="query" returnFormat="JSON">
		<cfargument name="productCodetoSearch" required="true" type="string">

		<cftry>
			<cfquery name="getSingleProduct">
				SELECT productCode, productName, productDesc 
				FROM myproducts
				WHERE productCode = <cfqueryparam value = "#arguments.productCodetoSearch#" cfsqltype="cf_sql_varchar">;
    		</cfquery>

    		<cfcatch type="any">
    			<cfset Super.exceptionLogger(cfcatch)/>
    			<cflocation url="somethingwentwrong.cfm"/>
    		</cfcatch>
    	</cftry>

  		<cfreturn getSingleProduct/>
	</cffunction>


	<!--- 
	Fetch record of all products from database
	
	Output:
	A query, which gives record of all products present in database
	--->
	<cffunction name="getAllProducts" access="remote" returntype="query" returnFormat="JSON">

		<cftry>
		<cfquery name="allProducts">
			SELECT productCode, productName, productDesc 
			FROM myproducts;
    	</cfquery>

    	<cfreturn allProducts/>

    	<cfcatch type="any">
    		<cfset Super.exceptionLogger(cfcatch)/>
    		<cflocation url="somethingwentwrong.cfm"/>
    	</cfcatch>
    	</cftry>
	</cffunction>


	<!--- 
	Create a new product in the database

	Input :
	productCodetoCreate: A string type argument, which is the new product's identification code
	productNametoCreate: A string type argument, which is the new product's name
	productDesctoCreate: A string type argument, which is the new product's description
	
	Output:
	A query, which gives the details of the product that matches the product ID	
	--->
	<cffunction name="createNewItem" access="remote" returntype="boolean" returnFormat="JSON">
		<cfargument name="productCodetoCreate" required="true" type="string">
		<cfargument name="productNametoCreate" required="true" type="string">
		<cfargument name="productDesctoCreate" required="true" type="string">

		<cftry>
		<cfset session.createErrors=ArrayNew(1)/>

		<cfif arguments.productCodetoCreate.trim() EQ '' OR arguments.productNametoCreate.trim() EQ '' OR arguments.productDesctoCreate.trim() EQ ''>
			<cfset arrayAppend(session.createErrors,'Make sure to fill up all the fields') />
		</cfif>

		<cfif 
		NOT isValid("regex", arguments.productCodetoCreate.trim(), "^[a-zA-Z0-9_]+$") 
		OR 
		NOT isValid("regex", arguments.productNametoCreate.trim(), "^[a-zA-Z0-9_ ]+$") 
		OR 
		NOT isValid("regex", arguments.productDesctoCreate.trim(), "^[a-zA-Z0-9_ ]+$")>
			<cfset arrayAppend(session.createErrors,'Make sure to fill up valid content before inserting') />
		</cfif>

		<!--- Check if product with that code already exists, return false if it does --->
		<cfset var existence=''>
		<cfquery name="checkExistence" result="existence">
			SELECT productCode FROM myproducts
			WHERE productCode = <cfqueryparam value = #Trim(arguments.productCodetoCreate)# cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfif existence.recordcount NEQ 0 AND arguments.productCodetoCreate NEQ ''>
			<cfset arrayAppend(session.createErrors,'Product with this ID already exists') />
		</cfif> 

		
		<cfif existence.recordcount EQ 0 AND arrayLen(session.createErrors) EQ 0>
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

		<cfif ArrayLen(session.createErrors) EQ 0>
			<cfreturn true/>
		</cfif>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
		
  		<cfreturn false />
	</cffunction>

</cfcomponent>