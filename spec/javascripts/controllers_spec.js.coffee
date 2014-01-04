# spec/javascripts/controllers_spec.js.coffee

describe "Site controllers", ->
  beforeEach module("site")

  describe "SiteIndexCtrl", ->
    it "should set sites to an empty array", inject(($controller) ->
      scope = {}
      ctrl = $controller("SiteIndexCtrl",
        $scope: scope
      )
      expect(scope.sites.length).toBe 1
    )
