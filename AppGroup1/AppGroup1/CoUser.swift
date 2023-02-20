//
//  CoUser.swift
//  AppGroup1
//
//  Created by Nicola Restaino on 20/02/23.
//

import Foundation

struct SCoUser : Identifiable {
    let id = UUID()
    let name : String
    let surname : String
    var balance : Float
    var email : String
}
