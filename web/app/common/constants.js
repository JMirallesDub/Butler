'user strict';
/*




*/
angular.module('app')
	.constant('CONSTANTS', { 
		"URL": "http://localhost:3000/api/",
		"LOGIN": "sessions/create",
		"LOGOUT": "sessions/destroy",
		"FORGOTPASS": "sessions/forgotPassword",
		"SIGNUP": "users/create",
		"CONFIRM_ACCOUNT": "users/confirmaccount",
		"CREATE_ORGANIZATION": "companies/create",
		"READ_ORGANIZATION": "companies/read",
		"UPDATE_ORGANIZATION": "companies/update",
		"DELETE_ORGANIZTION": "companies/destroy",
		"READ_ORGANIZATION_TYPE": "companies/types",
		"CREATE_BRANCH": "branchoffices/create",
		"READ_BRANCHOFFICES": "branchoffices/showByUser/",
		"CREATE_ROOM": "rooms/create",
		"READ_ROOMS": "rooms/showByBranch/",
		"DELETE_ROOMS": "rooms/destroy",
		"CREATE_ACTIVITY": "activities/create",
		"READ_ACTIVITIES": "activities/showByBranch/",
		"CREATE_SCHEDULE": "scheduleheaders/create",
		"READ_SCHEDULE": "scheduleheaders/show/",
		"UPDATE_SCHEDULE": "scheduleheaders/update",
		"DELETE_SCHEDULE": "scheduleheaders/delete",
		"READ_RESOURCETYPES": "resourcetypes/show",
		"CREATE_TIME": "scheduleheaders/addBody",
		"UPDATE_TIME": "schedulebodies/update",
		"DELETE_TIME": "schedulebodies/delete"
	});