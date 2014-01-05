# HomeCtrl specifically. This is basically how we tell
# Angular about the existence of our application.
@site = angular.module('site', ['ngRoute'])

# This routing directive tells Angular about the default
# route for our application.
@site.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/sites', {
      templateUrl: '../templates/sites/index.html.haml',
      controller: 'SiteIndexCtrl'
    }).
    when('/sites/:id', {
      templateUrl: '../templates/sites/show.html.haml',
      controller: 'SiteShowCtrl'
    }).
    otherwise({
      templateUrl: '../templates/home.html.haml',
      controller: 'HomeCtrl'
    })
])
