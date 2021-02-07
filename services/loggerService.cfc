<cfcomponent displayname="loggerServiceComponent">
	<cffunction name="exceptionLogger" output="false" access="package" >
		<cfargument name="catchbody" type="any" required="true">
		<cflog file="myAppLog" application="yes" text="Type - #arguments.catchbody.type#, Error Message - #arguments.catchbody.message#, Details - #arguments.catchbody.detail#">
	</cffunction>
</cfcomponent>