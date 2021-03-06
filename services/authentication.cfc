<cfcomponent output="false" displayname="authenticationServiceComponent" extends="loggerService">
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
		<cftry>
		<cfset session.aErrorMessages = ArrayNew(1) />
		<!---Validate the eMail---->
		<cfif arguments.userName EQ '' OR NOT isValid("regex", arguments.userName, "^[A-Za-z][A-Za-z0-9_]*")>
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

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
			<cflocation url="/CRUDApp/somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
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
			SELECT username, password, employee_id, role FROM user
			WHERE username=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar" />
			AND
			BINARY password=md5(<cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />);
		</cfquery>


		<cfif userDetected.recordCount EQ 1>

			<cfset session.loggedInUser = {'userID' = checkUser.employee_id, 'userName' = checkUser.username, 'role' = checkUser.role} />
			<cfset isUserLoggedIn = true />
			<cfset sessionRotate()/>

		<cfelse>
			<cfset arrayAppend(session.aErrorMessages,'User not found') />
		</cfif>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
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

		<cfset StructDelete(cookie, 'editMemory.editId', true)/>
		<cfset StructDelete(cookie, 'viewMemory.viewId', true)/>
		<cfset StructDelete(cookie, 'deleteMemory.deleteId', true)/>

		<cfcatch type="any">
			<cfset Super.exceptionLogger(cfcatch)/>
			<cflocation url="somethingwentwrong.cfm"/>
		</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

</cfcomponent>