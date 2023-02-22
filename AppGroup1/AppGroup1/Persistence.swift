//
//  Persistence.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 18/02/23.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "AppGroup1")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: {
            (storeDescription,error) in
            
            if let error = error as NSError? {
                
                fatalError("error \(error) , \(error.userInfo)")
            }
            
            
        })
        
        
        
    }
    
    static var preview : PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            let newExpense = Expense(context: viewContext)
            
            newExpense.title = "newEmpty"
            newExpense.desc = "newEmpty"
            newExpense.total = 0.0
            newExpense.uID = UUID()
            
        }
        let newBalance = Balance(context: viewContext)
        
        do {
            try viewContext.save()
        }
        catch {
            
            fatalError("Error while saving")
            
            
        }
        
        
        return result
    }()
    
    
    
    
}
