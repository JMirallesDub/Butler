'use strict';

/**
 * @ngdoc function
 * @name mytime.users.controller:signupCtrl
 * @description
 * # signup
 * Controller of the mytime.users
 */
angular.module('users')
	.factory('signupService', ['$http', '$q', 'CONSTANTS', 
		function($http, $q, CONSTANTS){
		var userInfo;
		var urlsignup = CONSTANTS.URL + CONSTANTS.SIGNUP;
		var urlconfirmaccount = CONSTANTS.URL + CONSTANTS.CONFIRM_ACCOUNT;

		return {
			createUser: function(userdata){
				return $http({method: "post", url: urlsignup, data: userdata});
			},
			confirmAccount: function(auth_token) {
				return $http({method: "post", url: urlconfirmaccount, data: auth_token});
			}
		}
	}]);
