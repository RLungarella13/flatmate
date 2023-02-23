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
        let query = ref.order(by: "date", descending: true)
        query.addSnapshotListener { snapshot, error in
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
                    let timestamp = data["date"] as? Timestamp ?? Timestamp()
                    let date = timestamp.dateValue()
                    
                    let expense = SExpense( id: id, title: title, desc: desc, total: total, date: date)
                    
                    switch change.type {
                    case .added:
                        self.expenses.append(expense)
                        self.expenses.sort { $0.date > $1.date }
                    case .modified:
                        if let index = self.expenses.firstIndex(where: { $0.id == expense.id }) {
                            self.expenses[index] = expense
                            self.expenses.sort { $0.date > $1.date }
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
        let timestamp = Timestamp(date: date)
        let ref = db.collection ("Expense").document(id)
        ref.setData([ "id":id, "title": title, "desc" : desc, "total" : total, "date": timestamp]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
}

