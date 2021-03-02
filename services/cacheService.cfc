<cfcomponent output="false" displayname="cacheServiceComponent">

	<cffunction name="retrieveVerifiedProductsCache" access="package" returntype="array" returnformat="JSON">
		<cftry>
			<cfif cacheIdExists("verifiedProductsCacheMemory")>
				<cfset var cacheDataArray = cacheGet("verifiedProductsCacheMemory")/>
				<cfif ArrayLen(cacheDataArray) EQ 0>
					<cfset syncProductsCache() />
				</cfif>
			<cfelse>
				<cfset syncProductsCache() />
				<cfset var cacheDataArray = cacheGet("verifiedProductsCacheMemory")/>
			</cfif>

			<cfreturn cacheDataArray />


			<cfcatch type="any">
				<cfset Super.exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>




	<cffunction name="retrieveUnverifiedProductsCache" access="package" returntype="array" returnformat="JSON">
		<cftry>
			<cfif cacheIdExists("unverifiedProductsCacheMemory")>
				<cfset var cacheDataArray = cacheGet("unverifiedProductsCacheMemory")/>
				<cfif ArrayLen(cacheDataArray) EQ 0>
					<cfset syncProductsCache() />
				</cfif>
			<cfelse>
				<cfset syncProductsCache() />
				<cfset var cacheDataArray = cacheGet("unverifiedProductsCacheMemory")/>
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
			<cfset cachePut("verifiedProductsCacheMemory", arrayNew(1))/>
			<cfset cachePut("unverifiedProductsCacheMemory", arrayNew(1))/>
			<cfquery name="verifiedProductsQuery" result="productsResult">
				SELECT productCode, productName, productDesc, price
				FROM myproducts
				WHERE verified='YES';
			</cfquery>

			<cfquery name="unverifiedProductsQuery" result="productsResult">
				SELECT productCode, productName, productDesc, price
				FROM myproducts
				WHERE verified='NO';
			</cfquery>

			<cfscript>
				verifiedProductsCacheObject=[];
				for (row in verifiedProductsQuery) 
				{
    				arrayAppend(verifiedProductsCacheObject, 
    					[row.productCode, row.productName, row.productDesc, row.price]
    				);
				}

				unverifiedProductsCacheObject=[];
				for (row in unverifiedProductsQuery) 
				{
    				arrayAppend(unverifiedProductsCacheObject, 
    					[row.productCode, row.productName, row.productDesc, row.price]
    				);
				}
			</cfscript>

			<cfset cachePut("verifiedProductsCacheMemory", verifiedProductsCacheObject, createTimespan(1,0,0,0),createTimespan(10,0,0,0)) />
			<cfset cachePut("unverifiedProductsCacheMemory", unverifiedProductsCacheObject, createTimespan(1,0,0,0),createTimespan(10,0,0,0)) />
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
			<cfset var cacheData = retrieveVerifiedProductsCache()/>
	
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