'use strict';

/**
 * @ngdoc function
 * @name mytime.login.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the mytime.login
 */
 angular.module ('users')
 	.controller ('signupCtrl', ['$scope', '$state', 'signupService', '$stateParams', 'sessionService', 
 		function ($scope, $state, signupService, $stateParams, sessionService){
	 		var userInfo = {auth_token: $stateParams.auth_token, user: 'anonymous'};
	 		$scope.userdata = {users:{user: "", pass: ""}};
	 		$scope.rw_pass = "";
			$scope.message = "";
			$scope.ok = true;

	 		$scope.equalpass = function() {
	 			$scope.ok = angular.equals($scope.userdata.users.pass, $scope.rw_pass);
	 		}
	 		$scope.signUp = function(){
	 			signupService.createUser($scope.userdata).then(function(user){
	 				$state.go('sendmail');
	 			}), function (error){

	 			}
	 		}
 			$scope.confirmAccount = function(){
 				sessionService.setSession (userInfo);
 			}
 		}]);