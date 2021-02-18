<cfcomponent displayname="loggerServiceComponent" extends="cacheService">
	<cffunction name="exceptionLogger" output="false" access="package" >
		<cfargument name="catchbody" type="any" required="true">
		<cflog file="myAppLog" application="yes" text="Type - #arguments.catchbody.type#, Error Message - #arguments.catchbody.message#, Details - #arguments.catchbody.detail#">
	</cffunction>

	<cffunction name="syncronizeCache" output="false" access="package" returnformat="JSON">
		<cftry>
			<cfset Super.syncProductsCache()/>

			<cfcatch type="any">
				<cfset exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="retrieveCache" output="false" access="package" returnformat="JSON" returntype="array">
		<cftry>
			<cfset var cacheData = Super.retrieveProductsCache()/>
			<cfreturn cacheData />

			<cfcatch type="any">
				<cfset exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getSingleCacheProduct" output="false" access="package" returnformat="JSON">
		<cfargument name="productCodetoSearchFromCache" required="true" type="string">
		<cftry>
			<cfset var codeParam = arguments.productCodetoSearchFromCache/>
			<cfset var cacheData = Super.getSingleProductFromCache(codeParam)/>
			<cfreturn cacheData />

			<cfcatch type="any">
				<cfset exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>