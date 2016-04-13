'use strict';
/*
Comments main function
*/

angular.module ('main')
	.controller ('mainCtrl', ['$scope', 'authService', function ($scope, authService){
		
		document.getElementById('searchTextBox').focus();
		
		$scope.show = function () {
			 return authService.authorized();
		}

		
		


	}]);