using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Application.Models
{
    public class BudgetModel
    {
        public int HouseholdId { get; set; }
        public int Id { get; set; }
        public int AccountId { get; set; }
        public decimal Limit { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public decimal CurrentSum { get; set; }
        public bool Active { get; set; }
    }
}