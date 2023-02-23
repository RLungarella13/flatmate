//
//  DataController.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 18/02/23.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "ExpenseModel")
    
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Core Data Failed To Load: \(error.localizedDescription)")
            }
            
        }
    }
}
