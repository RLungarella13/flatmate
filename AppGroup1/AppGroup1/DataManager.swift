//
//  DataManager.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 20/02/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject{
    @Published var users : [SCoUser] = []
    var balance = 0.0
    
    init (){
        fetchUsers()
    }
    
    func fetchUsers(){
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("User")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print (error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data ( )
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let surname = data["surname"] as? String ?? ""
                    let balance = data["balance"] as? Float ?? 0
                    let email = data["email"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let couser = SCoUser(id: id, name: name, surname: surname, balance: balance, email: email, password: password)
                    self.users.append(couser)
                }
            }
        }
    }
    
    func addUser (email: String, password: String) {
        print(email)
        let db = Firestore.firestore()
        let ref = db.collection ("User").document (email)
        ref.setData(["email": email, "id" : 10, "password" : password, "name" : "", "surname" : "", "balance": 0]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}


