'use strict';

/**
 * @ngdoc function
 * @name docker-registry-frontend.controller:DeleteRepositoryController
 * @description
 * # DeleteRepositoryController
 * Controller of the docker-registry-frontend
 */
angular.module('delete-repository-controller', ['registry-services'])
  .controller('DeleteRepositoryController', ['$scope', '$route', '$routeParams', '$location', '$log', '$filter', '$window', 'Repository',
  function($scope, $route, $routeParams, $location, $log, $filter, $window, Repository){
    $scope.repositoryUser = $route.current.params['repositoryUser'];
    $scope.repositoryName = $route.current.params['repositoryName'];

    $scope.deleteRepo = function() {
      var repoStr = $scope.repositoryUser + '/' + $scope.repositoryName;
      
      Repository.delete({repoUser: $scope.repositoryUser, repoName: $scope.repositoryName},
        // success
        function(value, responseHeaders) {
          toastr.success('Deleted repository: ' + repoStr);
          // Redirect to new tag page
          $window.location.href = '#/repositories';
        },
        // error
        function(httpResponse) {
          toastr.error('Failed to delete repository: ' + repoStr + ' Response: ' + httpResponse);
        }
      );
    };
  }]);