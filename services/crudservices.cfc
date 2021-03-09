<cfcomponent output="true" displayname="crudServiceComponent" extends="loggerService">

	<!--- 
	Fetch record of all filtered verified products from database

	Input:
	exportsortSubject: A string type argument, which is the column based on which the data is to be sorted

	exportorderSubject: A string type argument, which specifies whether the sort has to be ascending or descending

	exportminPrice: A integer type argument, which specifies the minimum price of filter criteria
	
	exportmaxPrice: A integer type argument, which specifies the maximum price of filter criteria

	Output:
	A query, which gives record of all filtered verified products present in database
	--->
	<cffunction name="getFilteredData" access="remote" returntype="query" returnFormat="JSON">

		<cfargument name="exportsortSubject" required="true" type="string">
		<cfargument name="exportorderSubject" required="true" type="string">
		<cfargument name="exportminPrice" required="true" type="numeric">
		<cfargument name="exportmaxPrice" required="true" type="numeric">

		<cfdump var="#arguments.exportminPrice#"/>
		<cfdump var="#arguments.exportmaxPrice#"/>

		<cfset var local.sortCriteria = arguments.exportsortSubject/>
		<cfif local.sortCriteria NEQ 'price' AND local.sortCriteria NEQ 'productName'>
			<cfset local.sortCriteria = 'productName'/>
		</cfif>

		<cfset var local.orderCriteria = arguments.exportorderSubject/>
		<cfif local.orderCriteria NEQ 'asc' AND local.orderCriteria NEQ 'desc'>
			<cfset local.orderCriteria = 'asc'/>
		</cfif>

		<cfset var local.minPrice = arguments.exportminPrice/>
		<cfset var local.maxPrice = arguments.exportmaxPrice/>

		<cftry>
		<cfquery name="allVerifiedProducts">
			SELECT productCode, productName, productDesc, price FROM myproducts WHERE verified='YES' AND price BETWEEN #local.minPrice# AND #local.maxPrice# ORDER BY #local.sortCriteria# #local.orderCriteria#;
    	</cfquery>

    	<cfcatch type="any">
    		<cfset Super.exceptionLogger(cfcatch)/>
    		<cfdump var="#cfcatch#"/>
    		<!--- <cflocation url="somethingwentwrong.cfm"/> --->
    	</cfcatch>
    	</cftry>

  		<cfreturn allVerifiedProducts/>
	</cffunction>




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
		<cfif session.loggedInUser.role EQ 'admin'>
		<cfquery name="deleteProduct">
				DELETE FROM myproducts
				WHERE productCode = <cfqueryparam value = "#arguments.productCodetoDelete#" cfsqltype = "cf_sql_varchar">;
		</cfquery>
		<cfset Super.syncronizeCache()/>
		</cfif>

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
		<cfargument name="newproductprice" required="true" type="string">


		<cftry>
		<cfif session.loggedInUser.role EQ 'admin'>

			<cfset session.editErrors=ArrayNew(1)/>

			<cfset local.CodetoEdit = Trim(arguments.productCodetoEdit)/>
			<cfset local.NametoEdit = Trim(arguments.newproductname)/>
			<cfset local.DesctoEdit = Trim(arguments.newproductdesc)/>
			<cfset local.PricetoEdit = val(Trim(arguments.newproductprice))/>

			<cfif local.CodetoEdit EQ '' OR local.NametoEdit EQ '' OR local.DesctoEdit EQ '' OR local.PricetoEdit EQ '0'>
				<cfset arrayAppend(session.editErrors,'Make sure to fill up all the fields') />
			</cfif>

			<cfif
			NOT isValid("regex", local.NametoEdit, "^[a-zA-Z0-9_ ]+$") 
			OR 
			NOT isValid("regex", local.DesctoEdit, "^[a-zA-Z0-9_ ]+$")
			OR
			NOT isValid("regex", local.PricetoEdit, "^[1-9]\d*(\.\d+)?$")>
				<cfset arrayAppend(session.editErrors,'Make sure to fill up valid content') />
			</cfif>

			<cfif arrayLen(session.editErrors) EQ 0>
			<cfquery name="editProduct">
				UPDATE myproducts
				SET productName = <cfqueryparam value = "#local.NametoEdit#" cfsqltype = "cf_sql_varchar">, 
				productDesc = <cfqueryparam value = "#local.DesctoEdit#" cfsqltype = "cf_sql_varchar">,
				price = <cfqueryparam value = "#local.PricetoEdit#" scale="2" cfsqltype = "cf_sql_decimal">
				WHERE productCode = <cfqueryparam value = "#local.CodetoEdit#" cfsqltype = "cf_sql_varchar">;
			</cfquery>

			<cfset Super.syncronizeCache()/>

			<cfif ArrayLen(session.editErrors) EQ 0>
				<cfreturn true/>
			</cfif>
			</cfif>
		</cfif>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
			<cfreturn false/>
		</cfcatch>

		</cftry>
		<cfreturn false />
	</cffunction>

	<!--- 
	Fetch a product from database based on its product code

	Input :
	productCodetoDelete: A string type argument, which is the product identification code
	
	Output:
	A query, which gives the details of the product that matches the product ID	
	--->
	<cffunction name="getProductbyId" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="productCodetoSearch" required="true" type="string">
		<cftry>
			<cfset var codeParam = arguments.productCodetoSearch/>
			<cfset var returnData = Super.getSingleCacheProduct(codeParam)/>
		
			<!--- <cfquery name="getSingleProduct">
				SELECT productCode, productName, productDesc 
				FROM myproducts
				WHERE productCode = <cfqueryparam value = "#arguments.productCodetoSearch#" cfsqltype="cf_sql_varchar">;
    		</cfquery> --->

    		<cfcatch type="any">
    			<cfset Super.exceptionLogger(cfcatch)/>
    			<cflocation url="somethingwentwrong.cfm"/>
    		</cfcatch>
    	</cftry>
    	<cfreturn returnData/>
  		<!--- <cfreturn SerializeJSON(getSingleProduct)/> --->
	</cffunction>


	<!--- 
	Fetch record of all verified products from database
	
	Output:
	A query, which gives record of all verified products present in database
	--->
	<cffunction name="getVerifiedProducts" access="remote" returntype="array" returnFormat="JSON">

		<cftry>
		<cfset Super.syncronizeCache()/>
		<cfset var cacheData = Super.retrieveVerifiedCache()/>
		<cfreturn cacheData/>

    	<cfcatch type="any">
    		<cfset Super.exceptionLogger(cfcatch)/>
    		<cflocation url="somethingwentwrong.cfm"/>
    	</cfcatch>
    	</cftry>
	</cffunction>



	<!--- 
	Fetch record of all unverified products from database
	
	Output:
	A query, which gives record of all unverified products present in database
	--->
	<cffunction name="getUnverifiedProducts" access="remote" returntype="array" returnFormat="JSON">

		<cftry>
		<cfset Super.syncronizeCache()/>
		<cfset var cacheData = Super.retrieveUnverifiedCache()/>
		<cfreturn cacheData/>

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
		<cfargument name="productPricetoCreate" required="true" type="string">

		<cftry>
		<cfset session.createErrors=ArrayNew(1)/>


		<cfset local.newCodetoCreate = Trim(arguments.productCodetoCreate)/>
		<cfset local.newNametoCreate = Trim(arguments.productNametoCreate)/>
		<cfset local.newDesctoCreate = Trim(arguments.productDesctoCreate)/>
		<cfset local.newPricetoCreate = val(Trim(arguments.productPricetoCreate))/>

		<cfif local.newCodetoCreate EQ '' OR local.newNametoCreate EQ '' OR local.newDesctoCreate EQ '' OR local.newPricetoCreate EQ '0'>
			<cfset arrayAppend(session.createErrors,'Make sure to fill up all the fields') />
		</cfif>

		<cfif 
		NOT isValid("regex", local.newCodetoCreate, "^[a-zA-Z0-9_]+$") 
		OR 
		NOT isValid("regex", local.newNametoCreate, "^[a-zA-Z0-9_ ]+$") 
		OR 
		NOT isValid("regex", local.newDesctoCreate, "^[a-zA-Z0-9_ ]+$")
		OR
		NOT isValid("regex", local.newPricetoCreate, "^[1-9]\d*(\.\d+)?$")>
			<cfset arrayAppend(session.createErrors,'Make sure to fill up valid content') />
		</cfif>

		<!--- Check if product with that code already exists, return false if it does --->
		<cfset var existence=''>
		<cfquery name="checkExistence" result="existence">
			SELECT productCode FROM myproducts
			WHERE productCode = <cfqueryparam value = #local.newCodetoCreate# cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cfif existence.recordcount NEQ 0 AND local.newCodetoCreate NEQ ''>
			<cfset arrayAppend(session.createErrors,'Product with this ID already exists') />
		</cfif> 

		
		<cfif existence.recordcount EQ 0 AND arrayLen(session.createErrors) EQ 0>
			<cfif session.loggedInUser.role EQ 'admin'>
				<cfquery name="insertNewProduct">
					INSERT INTO myproducts (productCode, productName, productDesc, price, verified)
					VALUES 
					(
						<cfqueryparam value = "#local.newCodetoCreate#" cfsqltype = "cf_sql_varchar">,
						<cfqueryparam value = "#local.newNametoCreate#" cfsqltype = "cf_sql_varchar">,
						<cfqueryparam value = "#local.newDesctoCreate#" cfsqltype = "cf_sql_varchar">,
						<cfqueryparam value = "#local.newPricetoCreate#" scale="2" cfsqltype = "cf_sql_decimal">,
						'YES'
					);
				</cfquery>
			<cfelse>
				<cfquery name="insertNewProduct">
					INSERT INTO myproducts (productCode, productName, productDesc, price, verified)
					VALUES 
					(
						<cfqueryparam value = "#local.newCodetoCreate#" cfsqltype = "cf_sql_varchar">,
						<cfqueryparam value = "#local.newNametoCreate#" cfsqltype = "cf_sql_varchar">,
						<cfqueryparam value = "#local.newDesctoCreate#" cfsqltype = "cf_sql_varchar">,
						<cfqueryparam value = "#local.newPricetoCreate#"  scale="2" cfsqltype = "cf_sql_decimal">,
						'NO'
					);
				</cfquery>

			</cfif>
			<cfset Super.syncronizeCache()/>
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



	<!--- 
	Marks the verified status of a prodct to 'YES'
	
	Input :
	productCodetoAccept: A string type argument, which is the product's identification code to mark as accepted

	Output:
	A boolean, which is the status of acceptance
	--->
	<cffunction name="acceptProduct" access="remote" returntype="boolean" returnFormat="JSON">

		<cfargument name="productCodetoAccept" required="true" type="string">

		<cftry>
		
		<cfquery name="markAsVerified" result="acceptedProductRecord">
			UPDATE myproducts
			SET verified='YES'
			WHERE productCode=<cfqueryparam value = #arguments.productCodetoAccept# cfsqltype = "cf_sql_varchar">;
		</cfquery>
		<cfset Super.syncronizeCache()/>

		<cfreturn true/>

    	<cfcatch type="any">
    		<cfset Super.exceptionLogger(cfcatch)/>
    		<cflocation url="somethingwentwrong.cfm"/>
    	</cfcatch>
    	</cftry>
	</cffunction>



	<!--- 
	Unverify the product and remove it from database
	
	Input :
	productCodetoReject: A string type argument, which is the product's identification code to mark as rejected

	Output:
	A boolean, which is the status of acceptance
	--->
	<cffunction name="rejectProduct" access="remote" returntype="boolean" returnFormat="JSON">

		<cfargument name="productCodetoReject" required="true" type="string">

		<cftry>
		
		<cfquery name="rejectProduct" result="acceptedProductRecord">
			DELETE FROM myproducts WHERE productCode=<cfqueryparam value = #arguments.productCodetoReject# cfsqltype = "cf_sql_varchar">;
		</cfquery>
		<cfset Super.syncronizeCache()/>

		<cfreturn true/>

    	<cfcatch type="any">
    		<cfset Super.exceptionLogger(cfcatch)/>
    		<cflocation url="somethingwentwrong.cfm"/>
    	</cfcatch>
    	</cftry>
	</cffunction>
</cfcomponent>