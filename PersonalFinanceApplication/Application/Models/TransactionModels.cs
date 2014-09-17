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
        public float Amount;
        public DateTime Date;
        public string Description;
    }
}
