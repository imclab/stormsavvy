@SiteCtrl = ($scope, $routeParams) ->
  $scope.data =
    sites: [{name: 'el chorizo', zipcode: '94530'}, {name: 'oaktown', zipcode: '94612'}]
    site: {name: 'el chorizo', zipcode: '94530'}
  $scope.data.siteId = $routeParams.siteId
