//
//  Expense.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 16/02/23.
//

import Foundation

class Expense{
    let uid: UUID
    var total: Double
    var contributors: [Int : Double]
    var Date: Date
    var title: String
    var desc: String
    init(uid: UUID, creditor: Person, debtors: [Person], total: Double, paid: Double,
         contributors: [Int : Double], Date: Date, title: String, desc: String) {
        self.uid = uid
        self.total = total
        self.contributors = contributors
        self.Date = Date
        self.title = title
        self.desc = desc
    }
}
