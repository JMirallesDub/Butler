'use strict';
/**/
angular.module('main', [])
	.config(function ($stateProvider){
		$stateProvider
      	.state('home', {
        url: "/",
        templateUrl: "common/main/main.tpl.html"
    	})
	});