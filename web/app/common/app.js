'use strict';

/**
 * @ngdoc overview
 * @name loginApp
 * @description
 * # loginApp
 *
 * Main module of the application.
 */
angular.module('app', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ui.router',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap',
    'main',
    'login',
    'organizations',
    'interceptors',
    'sessions',
    'authority',
    'users',
    'pascalprecht.translate',
    'tmh.dynamicLocale',
    'i18n',
    'ngFileUpload',
    'butler'
  ])
.config(['$stateProvider', '$urlRouterProvider', '$locationProvider',function ($stateProvider, $urlRouterProvider, $locationProvider) {
    
    $locationProvider.html5Mode(true);
    $urlRouterProvider.otherwise('/') 
}])




