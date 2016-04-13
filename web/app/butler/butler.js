'use strict';
/*
*/
angular.module('butler', [])
	.config(function ($stateProvider){
		$stateProvider
		.state('butleradmin', {
			url: "/mydashboard",
			templateUrl: 'butler/admin/mydashboard.tpl.html'
			/*resolve:{
				auth: function(authService){
					return authService.authorized();
				}
			}*/
		})
	});
