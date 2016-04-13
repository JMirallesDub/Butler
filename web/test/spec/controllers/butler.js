'use strict';

describe('Controller: butlerCtrl', function () {

  // load the controller's module
  beforeEach(module('ui.router'));
  beforeEach(module('sessions'));
  beforeEach(module('authority'));
  beforeEach(module('app'));
  beforeEach(module('login'));
  beforeEach(module('butler'));
  beforeEach(module('users'));
  beforeEach(module('i18n'));

  var butlerCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    butlerCtrl = $controller('butlerCtrl', {
      $scope: scope
    });
  }));

  it('Dani debe tener dos elementos', function () {
    expect(scope.dani.length).toBe(2);
  });
 
});
