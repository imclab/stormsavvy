@site.controller 'siteShowCtrl', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
  $http.get("./sites/#{$routeParams.id}.json").success((data) -> $scope.site = data
  )
]
