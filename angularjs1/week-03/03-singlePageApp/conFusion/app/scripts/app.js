'use strict';

angular.module('confusionApp', ['ngRoute'])
    .config(function ($routeProvider) { 
        $routeProvider
            //route for the contact us page    
            .when('/contactus', {
                templateUrl: 'contactus.html',
                controller: 'ContactController'
            })
            //route for the menu page    
            .when('/menu', {
                templateUrl: 'menu.html',
                controller: 'MenuController'
            })
            //route for the dish details page    
            .when('/menu/:id', {
                templateUrl: 'dishdetail-assign-2.html',
                controller: 'DishDetailController'
            })
            .otherwise('/contactus');
    })
    ;
