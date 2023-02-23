//
//  Persistence.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 18/02/23.
//
//commento
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
        
        let newLogin = LogIn().isLogin
        
        do {
            try viewContext.save()
        }
        catch {
            
            fatalError("Error while saving")
            
            
        }
        
        
        return result
    }()
    
    
    
    
}
