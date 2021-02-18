<cfcomponent output="false" displayname="cacheServiceComponent">

	<cffunction name="retrieveProductsCache" access="package" output="false" returntype="array" returnformat="JSON">

		<cftry>

			<cfif cacheIdExists("allProductsCacheMemory")>
				<cfset var cacheDataArray = cacheGet("allProductsCacheMemory")/>
				<cfif ArrayLen(cacheDataArray) EQ 0>
					<cfset syncProductsCache() />
				</cfif>
			<cfelse>
				<cfset syncProductsCache() />
				<cfset var cacheDataArray = cacheGet("allProductsCacheMemory")/>
			</cfif>

			<cfreturn cacheDataArray />


			<cfcatch type="any">
				<cfset Super.exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="syncProductsCache" access="package" output="false" returntype="boolean" returnformat="JSON">

		<cftry>
			<cfset cachePut("allProductsCacheMemory", arrayNew(1))/>
			<cfquery name="allProducts" result="productsResult">
				SELECT productCode, productName, productDesc 
				FROM myproducts;
			</cfquery>

			<cfscript>
				allProductsCacheObject=[];
				for (row in allProducts) 
				{
    				arrayAppend(allProductsCacheObject, 
    					[row.productCode, row.productName, row.productDesc]
    				);
				}
			</cfscript>

			<cfset cachePut("allProductsCacheMemory", allProductsCacheObject, createTimespan(1,0,0,0),createTimespan(10,0,0,0)) />
			<cfreturn true/>


			<cfcatch type="any">
				<cfset Super.exceptionLogger(cfcatch)/>
				<cfreturn false/>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getSingleProductFromCache" access="package" output="false" returnformat="JSON">
		<cfargument name="productCodetoSearchInCache" required="true" type="string">

		<cftry>
			<cfset var codeParam = arguments.productCodetoSearchInCache/>
			<cfset var returnData = structNew()/>
			<cfset var cacheData = Super.retrieveCache()/>
	
			<cfscript>
				returnData.DATA=ArrayFilter(cacheData, function(item){ return item[1]==codeParam;});
			</cfscript>

			<cfcatch type="any">
    			<cfset Super.exceptionLogger(cfcatch)/>
    			<cflocation url="somethingwentwrong.cfm"/>
    		</cfcatch>
		</cftry>

		<cfreturn returnData/>

	</cffunction>
</cfcomponent>