//
//  DataManagerNote.swift
//  Moneki
//
//  Created by Nicola Restaino on 22/02/23.
//

import SwiftUI
import Firebase

class DataManagerNote: ObservableObject{
    @Published var notes : [SNote] = []
    
    
    init (){
        fetchNotes()
    }
    
    func fetchNotes(){
        notes.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Note")
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
                    let content = data["content"] as? String ?? ""
                    
                    
                    let note = SNote( id: id, title: title, content: content, date: Date())
                    
                    switch change.type {
                    case .added:
                        self.notes.append(note)
                    case .modified:
                        if let index = self.notes.firstIndex(where: { $0.id == note.id }) {
                            self.notes[index] = note
                        }
                    case .removed:
                        if let index = self.notes.firstIndex(where: { $0.id == note.id }) {
                            self.notes.remove(at: index)
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    func addNote(id: String, title: String, content: String) {
        
        let db = Firestore.firestore()
        let ref = db.collection ("Note").document(id)
        ref.setData([ "id":id, "title": title, "content" : content, "date" : Date()]) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
}
