'use strict';

/**
 * @ngdoc function
 * @name docker-registry-frontend.controller:CreateTagController
 * @description
 * # CreateTagController
 * Controller of the docker-registry-frontend
 */
angular.module('create-tag-controller', ['registry-services'])
  .controller('CreateTagController', ['$scope', '$route', '$routeParams', '$location', '$log', '$filter', '$window', 'Tag', 'Repository',
  function($scope, $route, $routeParams, $location, $log, $filter, $window, Tag, Repository){
    $scope.imageId = $route.current.params['imageId'];    

    $scope.master = {};
    
    $scope.repositories = Repository.query();
    
    $scope.tag = { repoUser: null, repoName: null};
    $scope.selectRepo = function(repoStr) {
        var res = repoStr.split('/');
        $scope.tag.repoUser = res[0];
        $scope.tag.repoName = res[1]; 
    };
    
    $scope.doCreateTag = function(tag) {
      var tagStr = tag.repoUser + '/' + tag.repoName + ':' + tag.tagName;
      Tag.save(tag, '"'+$scope.imageId+'"',
        // success
        function(value, responseHeaders) {
          toastr.success('Created tag: ' + tagStr);
          // Redirect to new tag page
          $window.location.href = '#/tag/' + tag.repoUser + '/' + tag.repoName + '/' + tag.tagName + '/' + $scope.imageId;
        },
        // error
        function(httpResponse) {
          toastr.error('Failed to create tag: ' + tagStr + ' Response: ' + httpResponse);
        }
      );
    };
    
    $scope.createTag = function(tag, forceOverwrite) {
      $scope.master = angular.copy(tag);
      var tagStr = tag.repoUser + '/' + tag.repoName + ':' + tag.tagName;
      var tagExists = Tag.exists(tag,
        function(value, responseHeaders) {
          if (!forceOverwrite) {
            toastr.warning('Tag already exists: ' + tagStr);
            return;
          }
          $scope.doCreateTag(tag);
        },
        function(httpResponse) {
          $scope.doCreateTag(tag);
        }
      );
    };

    $scope.isUnchanged = function(tag) {
      return angular.equals(tag, $scope.master);
    };
  }]);