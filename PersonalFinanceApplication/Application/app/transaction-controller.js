app.controller("TransactionController", function ($scope, $rootScope, $routeParams, account) {
    $scope.accounts = account.accounts;
    $scope.$watch('accounts', function(oldValue, newValue) { alert("Changed"); updateAccount(newValue); });

    var myAccount = null;

    updateAccount(account.accounts);

    function updateAccount(accountList) {
        for(var i = 0; i < accountList.length; i++) {
            if (accountList[i].id == $routeParams.id) {
                myAccount = accountList[i];
                break;
            }
        }

        if (myAccount != null) {
            $rootScope.controllername = "Transactions for " + myAccount.name;
        } else {
            $rootScope.controllername = "Transactions for unknown"+ Math.random();
        }

        $scope.account = myAccount;
    }
});