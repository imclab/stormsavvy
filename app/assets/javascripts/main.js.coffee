# app/assets/javascripts/main.js.coffee

# This line is related to our Angular app, not to our
# HomeCtrl specifically. This is basically how we tell
# Angular about the existence of our application.
@site = angular.module('site', [])

# This routing directive tells Angular about the default
# route for our application.
@site.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    otherwise({
      templateUrl: '../templates/home.html.haml',
      controller: 'HomeCtrl'
    })
])
