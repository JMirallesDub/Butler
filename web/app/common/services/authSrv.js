'use strict'

/**
 * @ngdoc function
 * @name loginApp.controller:TimingCtrl
 * @description
 * # Timing
 * Controller of the loginApp
 */
 angular.module ('authority', [])
 	.factory ('authService', ['loginService', '$location', function(loginService, $location){
 		return{
 			authorized: function (){
 				if(loginService.loggedin()){
 					console.log("estoy autorizado");
 				}
 			},
 			unauthorized: function (){
 				if(!loginService.loggedin()){
 					console.log("no estoy autorizado me quedo en el login");
 					$location.path('/login');
 				}
 			}
 		}

 	}])