@IndexCtrl = ($scope, $location) ->
  $scope.data =
    sites: [{name: 'ecp', zipcode: '94531'}, {name: 'berkeley high', zipcode: '94709'}]
  $scope.viewSite = (siteId) ->
    $location.url('/site/'+siteId)
  $scope.title = "Active Sites"
