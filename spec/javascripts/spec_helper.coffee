#= require application
#= require angular-mocks

beforeEach(module('Site'))
beforeEach inject(($rootScope, $controller) ->
  scope = $rootScope.$new()
  IndexCtrl = $controller('IndexCtrl', {$scope: scope})
)
