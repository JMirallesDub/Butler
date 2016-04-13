'use strict';

angular.module('login', [])

	.config(function ($stateProvider){
		$stateProvider
			.state('login', {
				url: "/login",
				templateUrl: 'login/login.tpl.html'
			})
			.state('forgotpassword', {
				url:"/forgot_password",
				templateUrl: 'login/forgotPassword.tpl.html'
			})
			.state('resetpassword', {
				url:"/reset_password",
				templateUrl: 'login/resetPassword.tpl.html'
			})			
	});