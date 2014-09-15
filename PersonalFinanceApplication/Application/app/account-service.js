app.factory("account", function ($http) {

    this.accounts = [];

    function getAccounts() {
       var promise = $http.get("/api/Ledger").then(function(response)
        {
           console.log(response)
           return response.data; 
        });

        return promise;
    }

    function deleteAccount(id) {
        for (var i = 0; i < objects.length; i++) {
            if (objects[i].id == id) {
                objects.splice(i, 1);
                break;
            }
        }
    }

    function updateAccount(id, newAccount) {
        
    }

    return {
        getAccounts: getAccounts,
        deleteAccount: deleteAccount
    }
});
