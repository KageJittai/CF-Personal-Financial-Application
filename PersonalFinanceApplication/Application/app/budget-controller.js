app.controller("BudgetController", function ($scope, $rootScope, budget, account) {
    $rootScope.controllername = "Budget";

    $scope.budgets = budget.budgets;
    $scope.findById = account.findById;


});