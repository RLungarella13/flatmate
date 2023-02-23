//
//  SNote.swift
//  Moneki
//
//  Created by Nicola Restaino on 22/02/23.
//

import Foundation

struct SNote: Identifiable, Hashable{
    var id: String
    var title: String
    var content: String
    var date = Date()
 
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: SNote, rhs: SNote) -> Bool {
        return lhs.id == rhs.id
    }
}
