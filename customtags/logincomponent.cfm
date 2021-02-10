<cfoutput>

<div class="formcontainer">

		<h1 class="heading">#attributes.headingLine#</h1>

		<form class="form-content" name="loginform" method="post" action="loginpage.cfm">
			<div class="formfield username">
				<h3 class="formfield-header">Username</h3>
				<input spellcheck="false" autocomplete="off" class="form-input" type="text" name="username" value="">
			</div>
			
			<div class="formfield password">
				<h3 class="formfield-header">Password</h3>
				<input spellcheck="false" autocomplete="off" class="form-input" type="password" name="userpassword" value="">
			</div>

			<div class="formfield submitbutton">
				<input class="form-submit" type="submit" onclick="loginUser();" name="loginButton" value="Login">
			</div>
		</form>
</div>
		
		
		<!-- Validation error -->
		<cfif NOT ArrayIsEmpty(attributes.errorMessages)>
			<cfoutput>
				<cfloop array="#attributes.errorMessages#" item="message">
					<p class="validatormessage">#message#</p>
				</cfloop>
			</cfoutput>
		</cfif>
</cfoutput>