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
    it "should set location with site id", inject(($controller) ->
      scope = {}
      ctrl = $controller("IndexCtrl",
        $location: location
      )
      expect(location.url).toBe ('/site/'+siteID)
    )
