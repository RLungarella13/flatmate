//
//  Home.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import Foundation

class Home{
    let uid: UUID
    var home: [Person] // MARK: Verificare col DB, potrei anche farla solo di emails
    var expenses: [Expense] // MARK: Verificare col DB
    init(home: [Person], expenses: [Expense]) {
        self.home = home
        self.expenses = expenses
        self.uid = UUID.init()
    }
    
}
