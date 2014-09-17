app.controller("AccountsController", function ($scope, $rootScope, $location, account) {
    $rootScope.controllername = "Accounts";

    $scope.accounts = account.accounts;
    $scope.accountsTree = account.accountsTree;
    $scope.longName = account.longName;

    $scope.delete = function(item) {
        if (confirm("Do you wish to delete " + item.name + " and all children accounts")){
            account.deleteAccount(item.id);
        }
    }

    $scope.editOpen = function(item) {
        $scope.toEdit = {
            id: item.id,
            parentId: item.parentId,
            catagory: item.catagory,
            name: item.name
        };
        $("#CreateUpdateModal").modal('show');
    }

    $scope.createOpen = function() {
        $scope.toEdit = {
            id: null,
            parentId: null,
            catagory: 'INC',
            name: 'New Account'
        };
        $("#CreateUpdateModal").modal('show');
    }

    $scope.save = function() {
        if ($scope.toEdit.id == null)
        {
            account.createAccount($scope.toEdit);
        }
        else
        {
            account.updateAccount($scope.toEdit.id, $scope.toEdit);
        }
        $("#CreateUpdateModal").modal('hide');
    }

    $scope.gotoTransaction = function(item) {
        $location.path("/Transaction/" + item.id);
    }

    $scope.treeToRows = treeToRows;

    $scope.accountClicked = function (item) {
        item.expanded = (item.expanded ? false : true);
    }

    $scope.rowIcon = function (item) {
        if (item.children.length == 0) {
            return "glyphicon glyphicon-file";
        }

        if (item.expanded) {
            return "glyphicon glyphicon-plus";
        } else {
            return "glyphicon glyphicon-minus";
        }
    }

    function treeToRows(tree, level) {
        var ret = [];
        for (var i = 0; i < tree.length; ++i) {
            tree[i].level = level;
            ret.push(tree[i]);
            if (tree[i].children.length > 0 && tree[i].expanded == true)
                ret = ret.concat(treeToRows(tree[i].children, level + 1));
        }
        return ret;
    }
});