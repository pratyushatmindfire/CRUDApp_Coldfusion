<cfcomponent displayname="loggerServiceComponent">
	<cffunction name="exceptionLogger" output="false" access="package" >
		<cfargument name="eType" type="string" required="true">
		<cfargument name="eMessage" type="string" required="true">
		<cfargument name="eDetails" type="string" required="true">
		<cflog file="myAppLog" application="yes" text="Message - #arguments.eMessage#, Type - #arguments.eType#, Details - #arguments.eDetails#">
	</cffunction>
</cfcomponent>