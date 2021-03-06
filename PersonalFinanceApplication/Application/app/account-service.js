﻿app.service("account", function ($http) {

    var accounts = [];
    var tree = [];

    function refresh() {
        $http.get("/api/Ledger")
            .success(function (data, status, header, config) {
                // Delete all the accounts
                updateTree(data);
            });
    }

    function create(newAccount) {
        $http.post("api/Ledger/", newAccount)
            .success(refresh);
    }

    function update(id, newAccount) {
        $http.put("api/Ledger/" + id, newAccount)
            .success(refresh);
    }

    function remove(id) {
        $http.delete("api/Ledger/" + id)
            .success(refresh);
    }

    function updateTree(data) {
        var tempTree = [],
            tempDict = {};

        for (var i = 0; i < data.length; ++i) {
            var item = data[i];

            // initalize some default values
            // and add to the tempDict
            item.parent = null;
            item.children = [];
            item.expanded = true;
            tempDict[item.id] = item;

            // set the new value of extended to the old value
            var oldItem = findById(item.id);
            if (oldItem != null) {
                item.expanded = oldItem.expanded;
            }

            if (item.parentId == null) {
                tempTree.push(item);
            }
        }

        for (var i = 0; i < data.length; ++i) {
            var item = data[i];
            if (item.parentId != null) {
                tempDict[item.parentId].children.push(item);
                item.parent = tempDict[item.parentId];
            }
        }

        // Do some recursive math
        var recurse = function (base, parent) {

            base.tBalance = base.balance;
            base.tUnReconciled = base.unReconciled;
            base.tTransactions = base.transactions;

            for (var i = 0; i < base.children.length; i++) {
                recurse(base.children[i], base);
            }

            if (parent != null) {
                parent.tBalance += base.tBalance;
                parent.tUnReconciled += base.tUnReconciled;
                parent.tTransactions += base.tUnReconciled;
            }
        }

        for (var i = 0; i < tempTree.length; i++) {
            recurse(tempTree[i], null);
        }

        angular.copy(tempTree, tree);
        angular.copy(data, accounts);

        // Assign longName to accounts
        for (var i = 0; i < accounts.length; i++) {
            accounts[i].longName = longName(accounts[i].id);
        }
    }

    function findById(id) {
        if (id == null) {
            return { longName: '<None>' };
        }
        for (var i = 0; i < accounts.length; ++i) {
            if (accounts[i].id == id) {
                return accounts[i];
            }
        }

        return null;
    }

    function longName(id) {
        var __ref = findById(id);
        if (__ref.parentId == null)
            return __ref.name;
        else
            return longName(__ref.parentId) + ": " + __ref.name;
    }

    refresh();

    return {
        accounts: accounts,
        accountsTree: tree,
        findById: findById,
        create: create,
        update: update,
        remove: remove,
        refresh: refresh
    }
});
