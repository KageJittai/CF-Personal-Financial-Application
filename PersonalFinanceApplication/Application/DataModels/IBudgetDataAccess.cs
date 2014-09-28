using Application.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Application.DataModels
{
    public interface IBudgetDataAccess
    {
        Task CreateBudget(BudgetModel budget);

        Task UpdateBudget(BudgetModel budget);

        Task DeleteBudget(int HouseholdId, int BudgetId);

        Task<IList<BudgetModel>> GetBudget(int HouseholdId);
    }
}