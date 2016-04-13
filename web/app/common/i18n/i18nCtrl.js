'use strict';
/*Comments*/
angular.module ('i18n')	
	
	.controller('i18nCtrl', ['$scope', '$translate', '$window', function ($scope, $translate, $window) {
		
		if ($window.navigator.language == 'es-ES' || 'Español') {
			$scope.language = "menu.es"
		} else {
			$scope.language = "menu.en"
		}

		$scope.changeLanguage = function (idioma) {
			$translate.use(idioma);
			$scope.language = "menu." + idioma.substr(0,2);
		}
	}]);