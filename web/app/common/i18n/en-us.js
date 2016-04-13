'use strict';
/*Comments*/

angular.module('i18n')

	.config(function ($translateProvider){
		$translateProvider.useSanitizeValueStrategy('escaped');
		$translateProvider.translations( 'en-us', {
			"menu": {
				"login": "login",
				"buttler": "buttler",
				"signup": "signup",
				"logout": "logout",
				"en": "English",
				"es": "Spanish",
				"account": {
					"mydashboard": "My Dashboard",
					"myorganizations": " My Organizations",
					"myactivities": "My Activities",
					"myaccount": "Settings",
					"help": "Help",
					"logout": "logout"
				}
			},
			"main": {
				"msg_welcome": "Can I help you?"
			},
			"loginForm": {
				"signin": "Sign in",
				"mail": "Email Address or username",
				"password": "Password",
				"msg_error": "Incorrect  username and/or password",
				"rmb_pass": " Remember me for 30 days",
				"btn_send": " Sign in",
				"fgot_pass": "Forgot password?",
				"msg_account": "Don´t have an account?",
				"new_account": "Create Account"
			},
			"forgotForm": {
				"forgotpass": "Find your Account",
				"mail": "Enter your email",
				"btn_send": "Search",
				"msg_notfound": "We couldn't find your account with that information",
				"msg_found": "Email a link to "
			},
			"signupForm": {
				"signup": "Sign Up",
				"msg_equalpass": "",
				"msg_cond_click": "By clicking Join buttler, you agree with",
				"msg_cond_term": " Terms and Conditions",
				"msg_cond_clickand": " and ",
				"msg_cond_pp": "Privacy Policy.",
				"btn_send": "Continue",
				"msg_account": "Already on Buttler?",
				"signin": "Sign in"
			}
		});
	});