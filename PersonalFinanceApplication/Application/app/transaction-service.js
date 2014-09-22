app.service("transaction", function ($http) {

    function getTransactions(searchOptions) {
        return $http.get("api/Transaction", { params: searchOptions })
            .success(function(data) {
                for (var i = 0; i < data.length; i++) {
                    data[i].date = new Date(data[i].date);
                }
            });
    }

    return {
        getTransactions: getTransactions
    }
});
