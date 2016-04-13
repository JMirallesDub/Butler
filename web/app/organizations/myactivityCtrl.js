'use strict';
/*
*/
angular.module('organizations')
	.controller('myactivityCtrl', ['$scope', '$state', 'sessionService', 'organizationsService', 
		function($scope, $state, sessionService, organizationsService){

		$scope.$emit('login', sessionService.getSession().user);

	}])