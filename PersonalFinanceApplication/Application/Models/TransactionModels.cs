using Insight.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Application.Models
{
    public class TransactionModel
    {
        public int Id;
        public int? SourceAccount;
        public int? DestinationAccount;
        public decimal Amount;
        public DateTime Date;
        public string Description;
        public bool Reconciled;
        public int ResultSize;
    }

    public class TransactionSearchModel
    {
        public int HouseholdId {get; set;}

        public int? SourceAccount {get; set;}
        public int? DestinationAccount { get; set; }

        public int? Skip { get; set; }
        public int? Top { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public decimal? LowerAmount { get; set; }
        public decimal? UpperAmount { get; set; }
        public bool? ReconciledStatus { get; set; }
        public string Description { get; set; }
        public string OrderBy { get; set; }

        public TransactionSearchModel ToTransactionSearchModel()
        {
            return new TransactionSearchModel
            {
                SourceAccount = this.SourceAccount,
                DestinationAccount = this.DestinationAccount,
                Skip = this.Skip,
                Top = this.Top,
                StartDate = this.StartDate,
                EndDate = this.EndDate,
                LowerAmount = this.LowerAmount,
                UpperAmount = this.UpperAmount,
                ReconciledStatus = this.ReconciledStatus,
                Description = this.Description,
                OrderBy = this.OrderBy
            };
        }
    }
}
