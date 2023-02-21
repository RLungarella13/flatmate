//
//  DataManager.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 20/02/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject{
    @Published var expenses : [SExpense] = []
    
    
    init (){
        fetchExpenses()
    }
    
    func fetchExpenses(){
        expenses.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Expense")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print (error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data ( )
                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let desc = data["surname"] as? String ?? ""
                    let total = data["total"] as? Float ?? 0
                
                    let date = data["date"] as! Date
                    let expense = SExpense(id: id, title: title, desc: desc, total: total, date: date)
                    self.expenses.append(expense)
                }
            }
        }
    }
    
    func addExpense(id: String, title: String, desc: String, total: Float, date: Date) {
        
        let db = Firestore.firestore()
        let ref = db.collection ("Expense").document("id")
        ref.setData(["id" : 10, "title": title, "desc" : desc, "total" : total, "date": date]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}


