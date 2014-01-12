@IndexCtrl = ($scope) ->
  $scope.title = "Active Sites"
  $scope.data =
    sites: [{name: 'ecp', zipcode: '94530'}, {name: 'berkeley', zipcode: '94709'}]
