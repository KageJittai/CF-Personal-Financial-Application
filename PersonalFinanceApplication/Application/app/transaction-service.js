app.service("transaction", function ($http) {
    
    var transctions = [];

    function getAccountTransactions(accountId) {
        $http.get("api/Transation/" + accountId)
            .success()
    }

    return {

    }
});
