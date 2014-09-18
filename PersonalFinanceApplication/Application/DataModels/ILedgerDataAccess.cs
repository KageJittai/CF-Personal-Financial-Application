using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Application.Models;
using System.Threading.Tasks;

namespace Application.DataModels
{
    public interface ILedgerDataAccess
    {
        Task CreateAccount(int HouseholdId, string Name, int? ParentId, string Catagory);
        Task UpdateAccount(int HouseHoldId, int AccountId, string Name, int? ParentId);
        Task DeleteAccount(int HouseholdId, int AccountId);
        Task<IList<GetHouseholdAccountsResult>> GetHouseholdAccounts(int HouseholdId);
    }
}