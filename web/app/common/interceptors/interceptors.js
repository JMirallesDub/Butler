'use strict';

/**
 * @ngdoc function
 * @name mytime.common.Interceptor:requestInterceptor
 * @description
 * # rqInterceptor
 * Interceptor of the requests of mytime
 */
 angular.module('interceptors', [])
 .factory('sessionInjector', ['sessionService', '$q', function (sessionService, $q) {
  	
  	return{
    	request: function(config) {
    		var currentUser = sessionService.getSession(),
       		access_token = currentUser ? currentUser.auth_token : null;

      		if (access_token) {
        		config.headers['Authorization'] = access_token;
       		} 
      		return config;
    	},
    	requestError: function (rejection) {
    		return $q.reject(rejection);
    	},
    	responseError: function(errorResponse) {
           switch(errorResponse.status){
              case 404://Not Found
                if (errorResponse.data.errors == "Invalid session") {
                  console.log(errorResponse.data.errors);
                }
                break;
              case 500://if the status is 500 we return a Internal Server Error message
                console.log("Ha ocurrido un error inesperado, consulte con el administrador del sistema");
                break;
           } 
           return $q.reject(errorResponse);
    	}
  	}

 }])

 .config(['$httpProvider', function($httpProvider) {
 	$httpProvider.interceptors.push('sessionInjector');
 }])
