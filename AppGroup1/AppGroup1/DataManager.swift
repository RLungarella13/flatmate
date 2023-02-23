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
        ref.addSnapshotListener { snapshot, error in
            guard error == nil else {
                print (error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for change in snapshot.documentChanges {
                    let document = change.document
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let desc = data["desc"] as? String ?? ""
                    let total = data["total"] as? Float ?? 0
                    let date = data["date"] as? Date ?? Date() //possibile problema
                    let expense = SExpense( id: id, title: title, desc: desc, total: total, date: date)
                    
                    switch change.type {
                    case .added:
                        self.expenses.append(expense)
                    case .modified:
                        if let index = self.expenses.firstIndex(where: { $0.id == expense.id }) {
                            self.expenses[index] = expense
                        }
                    case .removed:
                        if let index = self.expenses.firstIndex(where: { $0.id == expense.id }) {
                            self.expenses.remove(at: index)
                        }
                    }
                }
                
            }
        }
    }
    func addExpense(id: String, title: String, desc: String, total: Float, date: Date) {
        
        let db = Firestore.firestore()
        let ref = db.collection ("Expense").document(id)
        ref.setData([ "id":id, "title": title, "desc" : desc, "total" : total, "date": date]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
}

