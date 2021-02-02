<cfcomponent output="true">
	<!--- 
	Validate the form field inputs

	Input :
	userName: A string type argument, which is the user's nameuser
	userPassword: A string type argument, which is the user's password 
	
	Output:
	An array, which is the array of error messages, can be empty if no errors		
	--->
	<cffunction name="validateUser" access="public" output="true" returntype="array">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<!--- <cfdump output = "D:/applog.html" format = "html" var="#arguments#"> --->
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



	<!--- 
	Login the user if the formfields are valid

	Input :
	userName: A string type argument, which is the user's nameuser
	userPassword: A string type argument, which is the user's password 
	
	Output:
	An boolean, which is the status of login		
	--->
	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />


		<cfset var isUserLoggedIn = false />

		<cfquery name="checkUser" result="userDetected">
			SELECT username, password, employee_id FROM user
			WHERE username=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar" />
			AND
			BINARY password=<cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />
		</cfquery>

		<cfif userDetected.recordCount EQ 1>

			<cfset session.loggedInUser = {'userID' = checkUser.employee_id, 'userName' = checkUser.username} />

			<cfset isUserLoggedIn = true />
		</cfif>

		<cfreturn isUserLoggedIn />
	</cffunction>



	<!--- 
	Logout the user by clearning the session variable

	Output:
	An boolean, which is the status of login	
	--->
	<cffunction name="doLogout" access="public" output="false" returntype="boolean">
		<cfset StructDelete(session,'loggedInUser') />
		<cfset StructDelete(Application, 'editMemory', true)/>
		<cfset StructDelete(Application, 'deleteMemory', true)/>
		<cfset StructDelete(Application, 'viewMemory', true)/>
		<cfreturn false />
	</cffunction>

</cfcomponent>