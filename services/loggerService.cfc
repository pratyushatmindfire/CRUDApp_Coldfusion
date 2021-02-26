<cfcomponent displayname="loggerServiceComponent" extends="cacheService" output="false">
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




	<cffunction name="retrieveVerifiedCache" access="package" returnformat="JSON" returntype="array">
		<cftry>
			<cfset var cacheData = Super.retrieveVerifiedProductsCache()/>
			<cfreturn cacheData />

			<cfcatch type="any">
				<cfset exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="retrieveUnverifiedCache" access="package" returnformat="JSON" returntype="array">
		<cftry>
			<cfset var cacheData = Super.retrieveUnverifiedProductsCache()/>
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