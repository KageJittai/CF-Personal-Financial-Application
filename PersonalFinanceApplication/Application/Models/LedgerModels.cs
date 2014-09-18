using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Application.Models
{
    public class GetHouseholdAccountsResult
    {
        public int Id;
		public int? ParentId;
		public string Name;
		public string Catagory;

		public int Transactions;
		public decimal Balance;
		public int UnReconciled;
    }

    public class LedgerModel
    {
        public int? ParentId { get; set; }
        public string Name { get; set; }
        public string Catagory { get; set; }

        public LedgerModel ToLedgerModel()
        {
            return new LedgerModel
            {
                ParentId = this.ParentId,
                Name = this.Name,
                Catagory = this.Catagory
            };
        }

    }
}