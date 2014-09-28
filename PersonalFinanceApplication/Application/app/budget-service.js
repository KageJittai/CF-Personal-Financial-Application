app.service("budget", function ($http) {

    var budgets = [];

    function refresh() {
        $http.get("api/Budget")
            .success(function (data) {
                angular.copy(data, budgets);
            });
    }

    function create(b) {
        return $http.post("api/Budget", b)
            .success(refresh);
    }

    function update(id, b) {
        return $http.put("api/Budget/" + id, b)
            .success(refresh);
    }

    function remove(id) {
        return $http.delete("api/Budget/" + id)
            .success(refresh);
    }

    refresh();

    return {
        budgets: budgets,
        refresh: refresh,
        create: create,
        update: update,
        remove: remove
    };
 });