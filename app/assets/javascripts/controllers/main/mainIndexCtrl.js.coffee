@IndexCtrl = ($scope, $location, $http) ->
  $scope.title = "Active Sites"
  $scope.data =
    # sites: [{name: 'ecp', zipcode: '94530'}, {name: 'berkeley', zipcode: '94709'}]
    sites: [{title: 'Loading sites...', contents: ''}]

  loadSites = ->
    $http.get('/sites.json').success( (data) ->
      $scope.data.sites = data
      console.log('Successfully loaded sites.')
    ).error( ->
      console.error('Failed to load sites.')
    )

  loadSites()

  $scope.viewSite = (siteId) ->
    $location.url('/site/'+siteId)
