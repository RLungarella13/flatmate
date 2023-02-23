//
//  DataManagerUser.swift
//  Moneki
//
//  Created by Nicola Restaino on 22/02/23.
//

import SwiftUI
import Firebase

class DataManagerUser: ObservableObject{
    @Published var users : [SUser] = []
    @Published var user : SUser = SUser(id: "TMvu9tQK3vHiNpM6Hp2a",balance: 0.0)
    
    init (){
        fetchCoUsers()
    }
    
    func fetchCoUsers(){
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("User")
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
                    let balance = data["balance"] as? Float ?? 0
                    self.user = SUser( id: id, balance: balance)
                    
                    switch change.type {
                    case .added:
                        self.users.append(self.user)
                    case .modified:
                        if let index = self.users.firstIndex(where: { $0.id == self.user.id }) {
                            self.users[index] = self.user
                        }
                    case .removed:
                        if let index = self.users.firstIndex(where: { $0.id == self.user.id }) {
                            self.users.remove(at: index)
                        }
                    }
                }
                
            }
        }
    }
    func addUser(id: String,  balance: Float) {
        
        let db = Firestore.firestore()
        let ref = db.collection ("User").document(id)
        let balance = user.balance + balance
        user.balance = balance
        ref.setData([ "id":id, "balance" : user.balance]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
}
