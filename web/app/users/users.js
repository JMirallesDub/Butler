'use strict';

angular.module ('users', [])

	.config(function ($stateProvider){
		$stateProvider
		.state('users', {
			url: "/signup",
			templateUrl: "users/signup.tpl.html"
			/*resolve:{
				auth: function(authService){
					return authService.authorized();
				}
			}*/
		})
		.state('sendmail', {
			url: "/sendmail",
			templateUrl: "users/sendMail.tpl.html"
		})
		.state('confirm', {
			url: "/confirm_account?auth_token",
			templateUrl: "users/confirmAccount.tpl.html"
		})
	});