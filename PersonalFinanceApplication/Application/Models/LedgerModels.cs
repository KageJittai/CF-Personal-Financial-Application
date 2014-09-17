using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Application.Models
{
    public class DetailedLedgerModel
    {
        public int Id;
		public int? ParentId;
		public string Name;
		public string Catagory;

		public int NumberSource;
		public decimal SourceSum;
		public int UnReconciledSource;

		public int NumberDestination;
        public decimal DestinationSum;
		public int UnReconciledDestination;
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