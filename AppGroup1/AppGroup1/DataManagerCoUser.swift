//
//  DataManager.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 20/02/23.
//

import SwiftUI
import Firebase

class DataManagerCoUser: ObservableObject{
    @Published var coUsers : [SCoUser] = []
    
    
    init (){
        fetchCoUsers()
    }
    
    func fetchCoUsers(){
        coUsers.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("CoUser")
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
                    let name = data["name"] as? String ?? ""
                    let surname = data["surname"] as? String ?? ""
                    let balance = data["balance"] as? Float ?? 0
                    let email = data["email"] as? String ?? ""
                    let coUser = SCoUser( id: id, name: name, surname: surname, balance: balance, email: email)
                    
                    switch change.type {
                    case .added:
                        self.coUsers.append(coUser)
                    case .modified:
                        if let index = self.coUsers.firstIndex(where: { $0.id == coUser.id }) {
                            self.coUsers[index] = coUser
                        }
                    case .removed:
                        if let index = self.coUsers.firstIndex(where: { $0.id == coUser.id }) {
                            self.coUsers.remove(at: index)
                        }
                    }
                }
                
            }
        }
    }
    func addCoUser(id: String, name: String, surname: String, balance: Float, email: String) {
        
        let db = Firestore.firestore()
        let ref = db.collection ("CoUser").document(id)
        ref.setData([ "id":id, "name": name, "surname" : surname, "balance" : balance, "email": email]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
}

