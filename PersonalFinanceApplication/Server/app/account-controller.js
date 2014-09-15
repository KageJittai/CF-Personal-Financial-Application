app.controller("AccountsController", function ($scope, $rootScope, account) {
    $rootScope.controllername = "Accounts";

    var treeControl = {};
    var tree = [];
    account.getAccounts().then(function(d) {
        updateTree(tree, d, 'id', 'parentId');
    });

    $scope.accountTreeData = tree;
    $scope.accountTreeControl = treeControl;
    $scope.accountColumes = [
    	{ field: "id" },
        { field: "parentId"},
        { field: "catagory"}
    ];

    $scope.controls = {};

    $scope.controls.delete = function(branch) {
        if (confirm("Do you wish to delete " + branch.name + " and all children accounts")){
            account.deleteAccount(branch.id);
            updateTree(tree, account.getAccounts(), 'id', 'parent');
            treeControl.expand_all();
        }
    }

    $scope.controls.edit = function(branch) {
        $scope.toEdit = {};
        $("#CreateUpdateModal").modal('show');
    }

    $scope.controls.create = function() {
        $scope.toEdit = null;
        $("#CreateUpdateModal").modal('show');
    }

    $scope.controls.save = function() {
    
    }

    $scope.accountSelected = function (branch) {
        branch.expanded = (branch.expanded ? false : true);
        branch.selected = false;
        treeControl.select_branch(null);
    }

    function updateTree(tree, data, primaryIdName, parentIdName) {
        if (!data || data.length == 0 || !primaryIdName || !parentIdName)
            debugger;

        // Empty any previous tree data
        while(tree.length > 0) {
            tree.pop();
        }

        var rootIds = [],
            item = data[0],
            primaryKey = item[primaryIdName],
            treeObjs = {},
            parentId,
            parent,
            len = data.length,
            i = 0;

        while (i < len) {
            item = angular.copy(data[i++]);
            primaryKey = item[primaryIdName];
            treeObjs[primaryKey] = item;
            parentId = item[parentIdName];

            if (parentId) {
                parent = treeObjs[parentId];

                if (parent.children) {
                    parent.children.push(item);
                }
                else {
                    parent.children = [item];
                }
            }
            else {
                rootIds.push(primaryKey);
            }
        }

        for (var i = 0; i < rootIds.length; i++) {
            tree.push(treeObjs[rootIds[i]]);
        };
    }
});