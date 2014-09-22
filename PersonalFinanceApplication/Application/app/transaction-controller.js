app.controller("TransactionController", function ($scope, $rootScope, account, transaction) {
    $scope.accounts = account.accounts;

    $scope.itemCount = 0;
    $scope.pageNumber = 1;
    $scope.pageSize = 10;

    $scope.minDateOpen = false;
    $scope.maxDateOpen = false;

    $scope.openMinDate = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.minDateOpen = true;
    }

    $scope.openMaxDate = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.maxDateOpen = true;
    }

    $scope.changeOrderBy = function (n) {
        $scope.orderBy = n;
        $scope.search();
    }

    $scope.orderBy = "-Date";
    $scope.findById = account.findById;

    $scope.resetSearch = function () {
        $scope.pageNumber = 1;

        $scope.searchText = null;

        $scope.sourceAccount = null;
        $scope.destinationAccount = null;

        $scope.reconciledStatus = null;

        $scope.minAmount = null;
        $scope.maxAmount = null;

        $scope.minDate = null;
        $scope.maxDate = null;
        
        $scope.search();
    }

    $scope.search = function() {
        var searchOptions = {
            skip: ($scope.pageNumber - 1) * $scope.pageSize,
            top: $scope.pageSize,
            sourceAccount: $scope.sourceAccount,
            destinationAccount: $scope.destinationAccount,
            startDate: $scope.minDate,
            endDate: $scope.maxDate,
            lowerAmount: $scope.minAmount,
            upperAmount: $scope.maxAmount,
            description: ($scope.searchText === "" ? null : $scope.searchText),
            orderBy: $scope.orderBy
        }

        transaction.getTransactions(searchOptions)
            .success(function(data) {
                $scope.data = data;
                if (data[0] != null)
                    $scope.itemCount = data[0].resultSize;
                else
                    $scope.itemCount = 0;
            });
    }

    $rootScope.controllername = "Transactions";
    
    // Do some initization
    $scope.resetSearch();

});