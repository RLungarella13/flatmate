//
//  SExpenseStore.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 19/02/23.
//

import Foundation

class ExpenseStore : ObservableObject {
    @Published var allExpenses = [SExpense]()
}
