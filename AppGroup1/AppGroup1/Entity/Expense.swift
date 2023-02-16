//
//  Expense.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 16/02/23.
//

import Foundation

class Expense{
    let uid: UUID
    var creditor: Person
    var debtors: [Person]
    var total: Double
    var paid: Double
    var Date: Date
    var title: String
    var desc: String
}
