'use strict';

angular.module('sessions',[])
.service('sessionService', ['$location', function ($location){
	var service = this,
	currentUser = null;

	//setter function for session user
	service.setSession = function(userInfo){
		currentUser = userInfo;
		sessionStorage["userInfo"] = JSON.stringify (userInfo);
		return currentUser;
	}
    //getter function for session user
	service.getSession = function(){
		if (typeof(sessionStorage["userInfo"]) != "undefined") {
			currentUser = JSON.parse(sessionStorage["userInfo"]);	
		} 
		return currentUser;
	}
	service.clearSession = function(){
		return sessionStorage.clear();
	}

}])