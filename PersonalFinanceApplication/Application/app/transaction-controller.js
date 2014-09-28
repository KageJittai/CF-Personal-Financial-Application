app.controller("TransactionController", function ($scope, $rootScope, account, transaction) {
    $scope.accounts = account.accounts;

    // Paging
    $scope.itemCount = 0;
    $scope.pageNumber = 1;
    $scope.pageSize = 10;

    // Date modals
    $scope.minDateOpen = false;
    $scope.maxDateOpen = false;
    $scope.editDateOpen = false;

    // Date modal open handlers
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

     $scope.openEditDate = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.editDateOpen = true;
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

        $scope.reconciledStatus = null;
        
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
            reconciledStatus: $scope.reconciledStatus,
            orderBy: $scope.orderBy
        }

        transaction.get(searchOptions)
            .success(function(data) {
                $scope.data = data;
                if (data[0] != null)
                    $scope.itemCount = data[0].resultSize;
                else
                    $scope.itemCount = 0;
            });
    }

    $scope.delete = function(id) {
        if (!confirm("Delete Transaction?"))
            return;

        transaction.remove(id)
            .success(function(){
                $scope.search();
            });
    }

    $scope.reconcile = function(record) {
        var toUpdate = angular.copy(record);
        toUpdate.reconciled = !record.reconciled;
        transaction.update(toUpdate.id, toUpdate)
            .success(function(){
                $scope.search();
            });
    }

    $scope.editOpen = function(item) {
        $scope.toEdit = null;
        $scope.toEdit = {
            id: item.id,
            sourceAccount: item.sourceAccount,
            destinationAccount: item.destinationAccount,
            date: item.date,
            description: item.description,
            amount: item.amount,
            reconciled: item.reconciled
        };
        $("#CreateUpdateModal").modal('show');
    }

    $scope.createOpen = function() {
        $scope.toEdit = null;
        $scope.toEdit = {
            id: null,
            sourceAccount: null,
            destinationAccount: null,
            date: new Date(),
            description: "",
            amount: 5.0
        };

        $("#CreateUpdateModal").modal('show');
    }

    $scope.save = function(toEdit) {
        var promise;
        if (toEdit.id == null)
            promise = transaction.create(toEdit);
        else
            promise = transaction.update(toEdit.id, toEdit);

        promise.success(function() {
            $scope.search();
        });

        $("#CreateUpdateModal").modal('hide');
    }

    $rootScope.controllername = "Transactions";
    
    // Do some initization
    $scope.resetSearch();

});