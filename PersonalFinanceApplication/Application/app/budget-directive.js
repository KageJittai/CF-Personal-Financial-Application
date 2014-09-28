app.directive("budget", function() {

    return {
        templateUrl: "app/template/budget-directive.html",
        restrict: "E",
        scope: {
            budget: '=budget',
            account: '=account'
        },
        link: function(scope, element, attrs) {
            scope.spendCurrent = Math.ceil(scope.budget.currentSum / scope.budget.limit * 100);

            scope.totalDays = daydiff(new Date(scope.budget.startDate),
                                      new Date(scope.budget.endDate));
            scope.daysPassed = Math.floor(daydiff(new Date(scope.budget.startDate), new Date()));
            scope.daysRemain = Math.ceil(daydiff(new Date(), new Date(scope.budget.endDate)));
            scope.daysWidth = Math.ceil(scope.daysPassed / scope.totalDays * 100);

            function daydiff(first, second) {
                var ret = (second.valueOf() - first.valueOf()) / 1000 / 60 / 60 / 24;
                return ret;
            }
        }
    };
 });