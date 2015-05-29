/*global angular */

(function () {
    "use strict";

    angular.module('myApp.services', ['ngResource']).factory('healthcareService', ['$resource', '$http',

        function ($resource) {
            var actions = {
                    'get': {method: 'GET'},
                    'save': {method: 'POST'},
                    'query': {method: 'GET', isArray: true},
                    'update': {method: 'PUT'},
                    'delete': {method: 'DELETE'}
                },
                db = {};
            // REST url to server
            db.healthcare = $resource('/api/healthcare/:_id', {}, actions);
            return db;
        }]);
}());