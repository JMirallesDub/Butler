'use strict';
/*

*/
angular.module ('organizations', [])

	.config(function ($stateProvider){
		$stateProvider
		.state('myorganizations', {
			url: "/myorganizations",
			templateUrl: 'organizations/organizations.tpl.html'
			/*resolve:{
				auth: function(authService){
					return authService.authorized();
				}
			}*/
		})
		.state('mybranchoffice', {
			url: "/mybranchoffice/:name/:id",
			templateUrl:  'organizations/mybranchoffice.tpl.html'
		})
		.state('activity', {
			url: "/activity/:name/:id",
			templateUrl: 'organizations/myactivity.tpl.html'
		})
	});

