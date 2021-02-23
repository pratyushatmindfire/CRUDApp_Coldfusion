<cfcomponent output="false" displayname="userdataServiceComponent" extends="loggerService">
	<cffunction name="getUserInfo" access="remote" returnType="string" returnFormat="JSON">
		<cftry>
			<cfreturn session.loggedInUser.role />

		<cfcatch type="any">
    		<cfset Super.exceptionLogger(cfcatch)/>
    		<cflocation url="somethingwentwrong.cfm"/>
    	</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>