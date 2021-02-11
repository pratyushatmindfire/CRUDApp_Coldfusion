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
    					[row.productCode, row.productName]
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
</cfcomponent>