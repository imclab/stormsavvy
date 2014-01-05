# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require_self
#= require_tree ./angular/services/global
#= require_tree ./angular/services/main
#= require_tree ./angular/filters/global
#= require_tree ./angular/filters/main
#= require_tree ./angular/controllers/global
#= require_tree ./angular/controllers/main
#= require_tree ./angular/directives/global
#= require_tree ./angular/directives/main

Site = angular.module('Site', ['ngRoute'])

Site.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/site', { templateUrl: '../assets/templates/mainSite.html.haml', controller: 'SiteCtrl' } )
  $routeProvider.otherwise({ templateUrl: '../assets/templates/mainIndex.html.haml', controller: 'IndexCtrl' } )
])
