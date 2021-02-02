<cfcomponent
	displayname="Application"
	output="true"
	hint="Handle the application.">


	<!--- Set up the application. --->
	<cfset THIS.Name = "AppCFC" />
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 10, 0 ) />
	<cfset This.SessionTimeout = createTimeSpan(0, 0, 2, 0) />
	<cfset THIS.SessionManagement = "Yes" />
	<cfset THIS.SetClientCookies = true />
	<cfset THIS.datasource = "classicmodels" />


	<!--- Define the page request properties. --->
	<cfsetting
		requesttimeout="20"
		showdebugoutput="false"
		enablecfoutputonly="false"
		/>


	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">

		<cflog file="AppLog" text="OnApplicationStart">
		<p>OnApplicationStart</p>

		<!--- Return out. --->
		<cfreturn true />
	</cffunction>


	<cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created.">

		<cflog file="AppLog" text="OnSessionStart">
		</p>OnSessionStart</p>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires at first part of page processing.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>

		<cflog file="AppLog" text="OnRequestStart">
		<p>OnRequestStart</p>
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>


	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>

		<!--- Include the requested page. --->
		<cfinclude template="#ARGUMENTS.TargetPage#" />

		<cflog file="AppLog" text="OnRequest">
		<!--- <p>OnRequest</p> --->
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequestEnd"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete.">

		<cflog file="AppLog" text="OnRequestEnd">
		<!--- </p>OnRequestEnd</p> --->
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnSessionEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="SessionScope"
			type="struct"
			required="true"
			/>

		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>

		<cflog file="AppLog" text="OnSessionEnd">
		<p>OnSessionEnd</p>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnApplicationEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the application is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>
		<cflog file="AppLog" text="Application terminated">
		<p>Application terminated</p>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>

	<cffunction 
		name="onMissingTemplate" 
		returntype="boolean" 
		output="false" >

    	<cfargument 
    		name="template" 
    		type="string" 
    		required="true" 
    		/>

    	<cflocation url="pagenotfound.cfm" />
		<cfabort />
	</cffunction>


	<cffunction
		name="OnError"
		access="public"
		returntype="void"
		output="true"
		hint="Fires when an exception occures that is not caught by a try/catch.">

		<!--- Define arguments. --->
		<cfargument
			name="Exception"
			type="any"
			required="true"
			/>

		<cfargument
			name="EventName"
			type="string"
			required="false"
			default=""
			/>

		<p>Some unhandled exception happened</p>
		<cfdump var=#Exception#>
		<cfreturn />
	</cffunction>

</cfcomponent>