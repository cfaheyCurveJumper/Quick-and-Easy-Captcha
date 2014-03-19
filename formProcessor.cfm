<cfoutput>

	<!--- default a captcha answer form field --->
	<cfparam name="form.captchaAnswer" default="">

	<!---
		if we have a captcha answer in the session
		AND session.captchaAnswer EQUALS form.captchaAnswer
	--->
	<cfif structkeyexists( session, "captchaAnswer" ) AND ( session.captchaAnswer EQ form.captchaAnswer )>

		<!--- then we can process our form as usual --->
		<h1>Your super-secret bank account number is: #form.topSecretBankAccountNumber#</h1>

	<!--- if validation failed --->
	<cfelse>

		<h1>Are you a robot? Don't you feel anything? Sometimes I feel like I'm the only one in this relationship who's trying.</h1>

	</cfif>

</cfoutput>