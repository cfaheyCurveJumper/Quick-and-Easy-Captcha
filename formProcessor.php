<?php
session_start();

	// default a captcha answer form field
	if ( ! $_POST['captchaAnswer'] ) {
		$_POST['captchaAnswer'] = "";
	}




	/*
		if we have a captcha answer in the session
		AND session.captchaAnswer EQUALS form.captchaAnswer
	*/
	if ( $_POST['captchaAnswer'] == $_SESSION['captchaAnswer'] ) {

		// then we can process our form as usual
		echo '<h1>Your super-secret bank account number is:' . $_POST['topSecretBankAccountNumber'] . '</h1>';

	// if validation failed
	} else {

		echo "<h1>Are you a robot? Don't you feel anything? Sometimes I feel like I'm the only one in this relationship who's trying.</h1>";
	}

?>