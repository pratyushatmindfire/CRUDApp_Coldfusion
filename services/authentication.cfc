<cfcomponent output="false">
	<!---validateUser() method--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />

		<cfset var aErrorMessages = ArrayNew(1) />
		<!---Validate the eMail---->
		<cfif arguments.userName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please, provide a valid userame') />
		</cfif>
		<!---Validate the password---->
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please, provide a password') />
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>



	<!---doLogin() method--->
	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />


		<cfset var isUserLoggedIn = false />

		<cfquery datasource="classicmodels" name="checkUser" result="userDetected">
			SELECT * FROM user
			WHERE username=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar" />
			AND
			password=<cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfif userDetected.recordCount EQ 1>

			<cfset session.loggedInUser = {'userID' = checkUser.employee_id, 'userName' = checkUser.username} />

			<cfset var isUserLoggedIn = true />
		</cfif>

		<cfreturn isUserLoggedIn />
	</cffunction>



	<!---doLogout() method--->
	<cffunction name="doLogout" access="public" output="false" returntype="boolean">

		<cfset structdelete(session,'loggedInUser') />
		<cfreturn false />
	</cffunction>

</cfcomponent>