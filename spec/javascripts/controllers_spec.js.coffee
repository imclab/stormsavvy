#= require spec_helper

describe "Site controllers", ->

  describe "mainIndexCtrl", ->
    it 'should work', -> expect(true).toBe(true)

    it "has variable text = \"stormsavvy\"", ->
      expect($scope.text).toEqual "stormsavvy"

    it "fetches list of users", ->
      $httpBackend = _$httpBackend_
      $httpBackend.when("GET", "./sites.json").respond [
        name: "ecp"
        zipcode: "94530"
      ,
        name: "berkeley"
        zipcode: "94709"
      ]
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
