<html>
	<head>
		<title>Form Page</title>
	</head>
	<body>
		<cfoutput>



			<!--- RIGHT BEFORE YOUR FORM STARTS --->
			<!--- vvvvvvvvvvvvvvvvvvvvvvvvvvvvv --->

			<!--- create an array representing yoru captcha images --->
			<!---
				file = the filename for the image
				name = the name you use to describe the image to your user
				UUID = a randomly generated unique identifier
			--->
			<cfset imagesArray = [
				{ file:"1.png", name:"cat", UUID: createUUID() },
				{ file:"2.png", name:"dog", UUID: createUUID() },
				{ file:"3.png", name:"fish", UUID: createUUID() },
				{ file:"4.png", name:"bird", UUID: createUUID() }
			]>

			<!--- randomly sort the array --->
			<cfset createobject( "java", "java.util.Collections" ).Shuffle( imagesArray )>

			<!--- pick a random number between 1 and the array length --->
			<cfset randNum = randrange( 1, arraylen( imagesArray ), "SHA1PRNG" )>

			<!--- get the image from the array at the index that matches our random number --->
			<cfset captchaAnswer = imagesArray[ randNum ]>

			<!--- store the randomly selected answer in the user's session --->
			<cfset session.captchaAnswer = captchaAnswer.UUID>

			<!--- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ --->
			<!--- AND WE'RE DONE GETTING READY FOR THE CAPTCHA --->



			<form action="formProcessor.cfm" method="post">

				<label>
					Your Bank Account Number (jk): <br>
					<input name="topSecretBankAccountNumber" type="text" size="30" value="">
				</label>



				<!--- RIGHT BEFORE OUR SUBMIT BUTTON --->
				<!--- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv --->

				<!--- add the captcha challenge text, which includes the name of the randomly chosen image --->
				<p>Please click the #captchaAnswer.name# to prove you're human:</p>

				<!--- loop over the array and output the images --->
				<cfloop array="#imagesArray#" index="thisImg">

				    <!--- we add a data attribute for later use by javascript and a class, also for JS use --->
				    <img src="#thisImg.file#" data-captchaanswer="#thisImg.UUID#" class="captchaImg">

				</cfloop>

				<!--- add a hidden field where we'll store the user's answer --->
				<input type="hidden" name="captchaAnswer" id="captchaAnswer"  value="">

				<!--- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ --->
				<!--- AND WE'RE DONE DISPLAYING OUR CAPTCHA CHALLENGE --->



				<button type="submit">submit</button>

			</form>

		</cfoutput>



		<!--- YOU'LL ALSO CREATE SOME JAVASCRIPT TO PROCESS THE CAPTCHA --->
		<!--- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv --->

		<!--- in this example we use jQuery --->
		<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>

		<script>

			// when the user clicks a captcha image
			$(document).on( "click", "img.captchaImg", function() {

				// get the answer value
				var thisAnswer = $(this).attr( "data-captchaanswer" );

				// and insert it into our hidden field
				$("#captchaAnswer").val( thisAnswer );

				// also, let's add a class to our selected image
				$(this).addClass("captchaAnswer");

				// and remove that class from any other images
				$(this).siblings().removeClass("captchaAnswer");

			} );
		</script>

		<!--- ^^^^^^^^^^^^^^^^^^^ --->
		<!--- JAVASCRIPT COMPLETE --->


		<!--- AND HERE"S A LITTLE CSS JUST TO MAKE A SELECTED IMAGE STAND OUT --->
		<!--- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv --->
		<style>
			img.captchaImg.captchaAnswer {
				border: 11px solid #ec8f00;
			}
		</style>
		<!--- ^^^^^^^ --->
		<!--- END CSS --->



	</body>
</html>

