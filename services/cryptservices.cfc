<cfcomponent output="false" displayname="cryptServiceComponent" extends="loggerService">

	<cffunction name="encryptData" access="remote" returntype="string" returnFormat="JSON">
		<cfargument name="datatoEncrypt" required="true" type="string">
		
		<cftry>

			<cfreturn URLEncodedFormat(arguments.encryptData)/>

			<cfcatch type="any">
				<cfset Super.exceptionLogger(cfcatch)/>
				<cflocation url="somethingwentwrong.cfm"/>
			</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>