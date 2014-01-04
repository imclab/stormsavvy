# app/assets/javascripts/angular/controllers/SiteIndexCtrl.js.coffee
#
@site.controller 'SiteIndexCtrl', ['$scope', '$location', '$http', ($scope, $location, $http) ->
  $scope.sites = []
  $http.get('./sites.json').success((data) ->
    $scope.sites = data
  )
]
