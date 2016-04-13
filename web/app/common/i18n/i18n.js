'use strict';
/*Comments*/

angular.module ('i18n', [])
	
	.config(function (tmhDynamicLocaleProvider){
		tmhDynamicLocaleProvider.localeLocationPattern("bower_components/angular-locale/angular-locale_{{locale}}.js");
	})

	.run(['$window', '$translate', 'tmhDynamicLocale', function ($window, $translate, tmhDynamicLocale){
		var language = ($window.navigator.userLanguage || $window.navigator.language ). indexOf('en') == 0 ? 'en-us' : 'es-es';
		$translate.use(language);
		tmhDynamicLocale.set(language);
	}]);
