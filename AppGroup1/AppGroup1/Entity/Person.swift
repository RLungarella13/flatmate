//
//  Person.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import Foundation

struct Person{
    let uid: UUID
    var name: String
    var surname: String
    var email: String // MARK: Da rendere univoca
    var password: String // MARK: Da codificare in SHA256
    var balance: Double
    var image: [UInt8]  // MARK: Verificare in seguito
}
