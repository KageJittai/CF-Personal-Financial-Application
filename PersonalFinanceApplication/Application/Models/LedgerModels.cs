using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Application.Models
{
    public class DetailedLedgerModel
    {
        public int Id;
		public int ParentId;
		public string Name;
		public string Catagory;

		public int NumberSource;
		public float SourceSum;
		public int UnReconciledSource;

		public int NumberDestination;
        public float DestinationSum;
		public int UnReconciledDestination;
    }

    public class LedgerModel
    {
        public int ParentId;
        public string Name;
        public string Catagory;
    }
}