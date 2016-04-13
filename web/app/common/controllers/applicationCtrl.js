'use strict';
/*
*/
angular.module('app')
	.controller('applicationCtrl', ['$scope', 'sessionService', function ($scope, sessionService){
			
		
			
			$scope.$on('login', function(event, user){
				$scope.currentUser = sessionService.getSession().user;
				$scope.userLogged = true;
			})
			
			$scope.$on('logout', function(){
				$scope.currentUser = null;
				$scope.userLogged = false;
			})
	}]);