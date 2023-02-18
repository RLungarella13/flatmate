//
//  AppGroup1App.swift
//  AppGroup1
//
//  Created by Raffaele Lungarella on 15/02/23.
//

import SwiftUI

@main
struct AppGroup1App: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
           TabBarView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

