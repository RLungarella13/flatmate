//
//  Expense.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 19/02/23.
//

import Foundation

struct SExpense : Identifiable {
    let id = UUID()
    let title : String
    let desc : String
    var total : Float
    var date : Date
}
