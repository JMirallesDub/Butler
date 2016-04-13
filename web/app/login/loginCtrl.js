'use strict';

/**
 * @ngdoc function
 * @name mytime.login.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the mytime.login
 */
 angular.module('login')
    .controller('loginCtrl', ['$scope', '$state', 'loginService', 'sessionService', function ($scope, $state, loginService, sessionService) {
        
        $scope.credentials = {
                user: "", 
                pass: ""
        };
        $scope.forgotPassword = {
            email: ""
        };

      	$scope.signIn = function () {
        	loginService.login($scope.credentials).then(function(user){
                $scope.userInfo = user;
                sessionService.setSession($scope.userInfo); //Create session user in sessionStorage
                $scope.$emit('login', sessionService.getSession().user);
                $state.go('butleradmin');
            }), function (error){

            }
        }
        $scope.signOut = function(){
            loginService.logout();
            $scope.$emit('logout');
            $state.go('home');
        }
        $scope.forgotPass = function(){
            console.log($scope.forgotPassword);
        	loginService.sendReset($scope.forgotPassword).then(function(result){
                $scope.forgotPass.msg = "forgotForm.msg_found";
            }), function(error) {
                $scope.forgotPass.msg = "forgotForm.msg_notfound";
            }
        }

	}]);

 




