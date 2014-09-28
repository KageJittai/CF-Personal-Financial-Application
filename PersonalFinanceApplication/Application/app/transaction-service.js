app.service("transaction", function ($http, account, budget) {

    function get(searchOptions) {
        return $http.get("api/Transaction", { params: searchOptions })
            .success(function(data) {
                for (var i = 0; i < data.length; i++) {
                    data[i].date = new Date(data[i].date);
                }
            });
    }

    function create(transaction) {
        return $http.post("api/Transaction", transaction)
            .success(account.refresh)
            .success(budget.refresh);
    }

    function update(id, transaction) {
        return $http.put("api/Transaction/" + id, transaction)
            .success(account.refresh)
            .success(budget.refresh);
    }

    function remove(id) {
        return $http.delete("api/Transaction/" + id)
            .success(account.refresh)
            .success(budget.refresh);
    }

    return {
        get: get,
        create: create,
        update: update,
        remove: remove
    }
});
