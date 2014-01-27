# spec/javascripts/controllers_spec.js.coffee

describe "Site controllers", ->
  scope = undefined
  $httpBackend = undefined

  # beforeEach module("Site")
  beforeEach angular.mock.module("Site")
  beforeEach angular.mock.inject(($rootScope, $controller, _$httpBackend_) ->
    $httpBackend = _$httpBackend_
    $httpBackend.when("GET", "./sites.json").respond [
      name: "ecp"
      zipcode: "94530"
    ,
      name: "berkeley"
      zipcode: "94709"
    ]

    scope = $rootScope.$new()
    $controller "IndexCtrl",
      $scope: scope
  )

  describe "mainIndexCtrl", ->
    it "has variable text = \"stormsavvy\"", ->
      expect(scope.text).toEqual "stormsavvy"

    it "fetches list of users", ->
      $httpBackend.flush()
      expect(scope.sites.length).toBe 2
      expect(scope.sites[0].name).toBe "ecp"
      expect(scope.sites[0].zipcode).toBe "94530"
      expect(scope.sites[1].name).toBe "berkeley"
      expect(scope.sites[1].zipcode).toBe "94709"

    it "sets sites to an empty array", inject(($controller) ->
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
