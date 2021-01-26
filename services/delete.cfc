<cfcomponent output="false">

	<cffunction name="deleteItem" access="public" returnType="void">
		<cfargument name="productCodetoDelete" required="true">



		<cfquery datasource="classicmodels" name="deleteProduct">
				DELETE FROM products
				WHERE productCode = <cfqueryparam value = "#productCodetoDelete#" cfsqltype = "cf_sql_varchar">;
		</cfquery>

		<cflocation url="loginpage.cfm">
	</cffunction>

</cfcomponent>