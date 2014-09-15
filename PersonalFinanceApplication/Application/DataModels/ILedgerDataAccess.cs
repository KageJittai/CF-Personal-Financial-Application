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
        Task CreateAccount(int HouseholdId, LedgerModel Ledger);
        Task UpdateAccount(int HouseHoldId, int AccountId, string NewName);
        Task DeleteAccount(int HouseholdId, int AccountId);
        Task<IList<DetailedLedgerModel>> GetHouseholdAccounts(int HouseholdId);
    }
}