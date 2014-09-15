﻿var app = angular.module("app", ['ngRoute', 'ngSanitize', 'treeGrid']);

app.config(function ($routeProvider) {
    $routeProvider
        .when("/", {
            templateUrl: 'app/template/dashboard.html',
            controller: 'DashboardController'
        })

        .when("/Accounts", {
            templateUrl: 'app/template/accounts.html',
            controller: 'AccountsController'
        })

        .when("/Household", {
            templateUrl: 'app/template/household.html',
            controller: 'HouseholdController'
        })

        .when("/Budget", {
            templateUrl: 'app/template/budget.html',
            controller: 'BudgetController'
        })

});


app.controller("DashboardController", function ($scope, $rootScope) {
    $rootScope.controllername = "Dashboard";
});

app.controller("HouseholdController", function ($scope, $rootScope) {
    $rootScope.controllername = "Household";
});

app.controller("BudgetController", function ($scope, $rootScope) {
    $rootScope.controllername = "Budget";
});