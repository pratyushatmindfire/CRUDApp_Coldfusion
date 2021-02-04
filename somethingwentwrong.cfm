<cfmodule template="./customtags/htmlheader.cfm" pagetitle="Something went wrong">

<body>

	<!-- Show somethingwentwrong page when some exception occurs -->
	<cfmodule template="./customtags/fallback.cfm" heading="OOPS" content="SOMETHING WENT WRONG">

</body>
</html>