﻿using Application.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace Application.DataModels
{
    public interface ITransactionDataAccess
    {
        Task<IList<TransactionModel>> GetTransactions(TransactionSearchModel search);
    }
}