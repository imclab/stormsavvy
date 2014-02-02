#= require application
#= require angular-mocks

beforeEach(module('Site'))
beforeEach inject(($rootScope, $controller, _$httpBackend_) ->
  $httpBackend = _$httpBackend_
  scope = $rootScope.$new()
  IndexCtrl = $controller('IndexCtrl', {$scope: scope})
)
