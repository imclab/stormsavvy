# spec/javascripts/controllers_spec.js.coffee

describe "Site controllers", ->
  beforeEach module("Site")
  # beforeEach(angular.mock.module('Application'));

  describe "mainIndexCtrl", ->
    it "should set sites to an empty array", inject(($controller) ->
      scope = {}
      ctrl = $controller("IndexCtrl",
        $scope: scope
      )
      expect(scope.sites.length).toBe 1
    )
