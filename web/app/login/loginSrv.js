'use strict';

/**
 * @ngdoc function
 * @name loginApp.controller:TimingCtrl
 * @description
 * # Timing
 * Controller of the loginApp
 */
angular.module('login')
	.factory('loginService',['$http', '$q', '$location', '$state', 'sessionService', 'CONSTANTS', 
		function($http, $q, $location, $state, sessionService, CONSTANTS){

		var userInfo;
		var urllogin =  CONSTANTS.URL + CONSTANTS.LOGIN;
		var urllogout = CONSTANTS.URL + CONSTANTS.LOGOUT;
		var urlforgotpass = CONSTANTS.URL + CONSTANTS.FORGOTPASS;
		var currentUser = {};

		return{
			login: function(login){
				var deferred = $q.defer();
 				$http(
 					{	method: "post", 
 						url: urllogin, 
 						data: login
 					})
 				.success(function(response){
 					deferred.resolve(response);
 				})
 				.error(function(err) {
 					deferred.reject(err);
 				});
 				return deferred.promise;		
			},
			logout: function(){
				var deferred = $q.defer();
				$http(
					{	method: "post", 
						url: urllogout, 
						headers: {}
					}).then(function(response){
						sessionService.clearSession();
						deferred.resolve(response);
					}), function (error){
						deferred.reject(err);
					}
				return deferred.promise;
			},
			Loggedin: function(){
				return sessionService.getSession();
			},
			sendReset: function(email){
				var deferred = $q.defer();
				$http(
					{	method: "post", 
						url: urlforgotpass, 
						data: email
					})
				.success(function(response){
					deferred.resolve(response);
				})
				.error(function(err){
					deferred.reject(err);
				});
				return deferred.promise;
			}
		}
 }]);