<cfcomponent output="false">
	<!--- 
	Validate the form field inputs

	Input :
	userName: A string type argument, which is the user's nameuser
	userPassword: A string type argument, which is the user's password 
	
	Output:
	An array, which is the array of error messages, can be empty if no errors		
	--->
	<cffunction name="validateUser" access="remote" output="false" returntype="boolean" returnformat="JSON">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<!--- <cfdump output = "D:/applog.html" format = "html" var="#arguments#"> --->
		<cfset session.aErrorMessages = ArrayNew(1) />
		<!---Validate the eMail---->
		<cfif arguments.userName EQ ''>
			<cfset arrayAppend(session.aErrorMessages,'Please, provide a valid userame') />
		</cfif>
		<!---Validate the password---->
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(session.aErrorMessages,'Please, provide a password') />
		</cfif>


		<cfif arrayLen(session.aErrorMessages) EQ 0>
			<cfreturn true/>
		<cfelse>
			<cfreturn false/>
		</cfif>
	</cffunction>



	<!--- 
	Login the user if the formfields are valid

	Input :
	userName: A string type argument, which is the user's nameuser
	userPassword: A string type argument, which is the user's password 
	
	Output:
	An boolean, which is the status of login		
	--->
	<cffunction name="doLogin" access="remote" output="false" returntype="boolean" returnformat="JSON">

		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />

		<cftry>
		<cfset var isUserLoggedIn = false />
		<cfset session.aErrorMessages = ArrayNew(1) />

		
		<cfquery name="checkUser" result="userDetected">
			SELECT username, password, employee_id FROM user
			WHERE username=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar" />
			AND
			BINARY password=<cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />
		</cfquery>


		<cfif userDetected.recordCount EQ 1>

			<cfset session.loggedInUser = {'userID' = checkUser.employee_id, 'userName' = checkUser.username} />

			<cfset isUserLoggedIn = true />

		<cfelse>
			<cfset arrayAppend(session.aErrorMessages,'User not found') />
		</cfif>

		<cfcatch type="any">
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>

		<cfreturn isUserLoggedIn />
	</cffunction>



	<!--- 
	Logout the user by clearning the session variable

	Output:
	An boolean, which is the status of logout	
	--->
	<cffunction name="doLogout" access="remote" output="false" returntype="boolean" returnformat="JSON">
		<cftry>
		<cfset StructDelete(session,'loggedInUser') />
		<cfset StructDelete(session, 'editMemory', true)/>
		<cfset StructDelete(session, 'deleteMemory', true)/>
		<cfset StructDelete(session, 'viewMemory', true)/>

		<cfcatch type="any">
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

</cfcomponent>