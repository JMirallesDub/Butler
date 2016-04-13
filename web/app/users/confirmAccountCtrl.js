'use strict';
/**/
angular.module('users')
	.controller('confirmAccountCtrl', ['$scope', '$stateParams', 'signupService', 
				function ($scope, $stateParams, signupService){
		
		$scope.auth_token = $stateParams.auth_token;

		signupService.confirmAccount($scope.auth_token).then(function(){
			$scope.message = true;
		})
	}])